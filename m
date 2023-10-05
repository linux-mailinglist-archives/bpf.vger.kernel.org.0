Return-Path: <bpf+bounces-11439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E17B9D7C
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2A2F21F232F1
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B322F1A;
	Thu,  5 Oct 2023 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7MsBV8m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eEL5iO3q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780D1A27F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:46:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2C287C0
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 06:46:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950BURB026772;
	Thu, 5 Oct 2023 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=umICQKTruoJM2DjY3KI3eLKYtM3wSueTKtp6ZVHa63I=;
 b=T7MsBV8m4KdKBFXLQwtaNQGHwcoz1UJOwCFdzG++/eKecA9By2W59MTE2gnzheOo51ab
 MM4hhWGrojaVviq3TVNyItt8bzoH3HiWcMZWrClFakrpLDtqhd8MkUbnAfKG51iEQ287
 GdAQgJeABoS1Qss+j5BIETuvepJh+BEZTBzHtaFvUu8Ey6yq72j7eq3NiX0KpXCZEv17
 9P5F8wVtK4VMFBZf/bnOmVmPZEOMwXSuDJG3aROmWbJYybq9UTiFNvp8ZfovHpJfwL2N
 +Vg0ntsatuu1NVMoKpzAhkd1AKLxq2a8w+PNDQR/ysKl+gteHF8XfsT1HB1QTzbQZtk0 QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eh0rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Oct 2023 09:04:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3956lRso003183;
	Thu, 5 Oct 2023 09:04:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48stdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Oct 2023 09:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQwMCxsPnDDaUcFcC5q61W3+I5fJugaDw2+o05x2DfHA49iDTRkzUZtztF6fWIW2+LQJ7hqYS9b80NxcvP+G4dhAwpRlW+TF0vJs8jjgOHWeX1Ky1KqWMuzHmYH0hoCrYTyVQFW+PtFqcIefFhADc1jbmDts9uMoJIRB1J78fvtODqaMAXNeTnk/aK4RbfZaDpTr3GNzx7Z+Oz2+pd5BQ8nDXBuWmSi+NOYe38IyPOvzM1Wh7plXnNiNkkN+gNYfP8Ox2osXysSIV4lEF+eQlvkvLxXBBy5+QcR8P5A352/MgRXNqjUkRrsIn3IMS977g/pTKK79m+oUk5RNXj4i1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umICQKTruoJM2DjY3KI3eLKYtM3wSueTKtp6ZVHa63I=;
 b=IfJxRVzxgtT5z2KcOHmpvg3ah6f2naCv37qPT3QlPKEfQYZH1B3ANZTMkwZsQaJUmiOIk/EpzqdCWrtIGeMt6U/nOVOOh37/RSF0yL7Ulaaouapp9pE4Peh8fBiLSpHkxcV4g+hPN1mUS2NchtrzNDwvNU5HOjv4K1JYfLSa65sivkN5oDMDGmUS+taGAaDZQ+/mLuZrTWidkKjBqKuMlW5a8TbVeVxQqQX+7M1tF7ngv205BfIcBhk4+i/SmQ1DnZ1dw1awemt8RW8XUDAeVpbJNDoSE9aHdo0aqh2EbdKPr4CdQnRAd+JGIS/wefQ+sqx+1I2+HOlW9/XLTd8yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umICQKTruoJM2DjY3KI3eLKYtM3wSueTKtp6ZVHa63I=;
 b=eEL5iO3q2ShR+pXzBn4bxx0D5AR9L+gSAzGLJPQszjMZ447b/wvpcChPPuWl2pwTWi/smHPDQqB566MzakW1Z3sKPb44/0bcWDzv8soVMvtsE86rtZvUuwRrYyN3CkHSVcumaxQ/VB9gEbMmI/+Ybn8J+OJ3t05Tpn9vLHLSVQ8=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.36; Thu, 5 Oct 2023 09:04:40 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 09:04:40 +0000
Message-ID: <e4993aa4-2162-b227-d14e-6d521931c6e0@oracle.com>
Date: Thu, 5 Oct 2023 10:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: support building selftests in
 optimized -O2 mode
To: Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
References: <20231004001750.2939898-1-andrii@kernel.org>
 <20231004001750.2939898-2-andrii@kernel.org> <ZR0h12W2AHvquBWv@krava>
 <CAEf4Bzag+5_r05t7p2N-XiWykT51U5x4ov7YSa0NGVJrGpo6UQ@mail.gmail.com>
 <ZR5jfh939hHLtnED@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZR5jfh939hHLtnED@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::17) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CH0PR10MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9574a6e4-2708-4fbd-0db6-08dbc5821b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zx8gn15VQFosDHFd1rXDNiaUynjElsOHhgjmP//GbgxkyM6BjpSk4X2MAvJvW4M3h9N7FtdPbp85e/H+ZG2b4Km1W9A1EvUJY63qf7qnpyy8cOrJICSQ7mr9yk/tG73Mv/1w/oFMXxKmrqXeJF4FNstelkov9GfYWMtN3ONEw+Y+hOwDFvt/sFOC8O27NXlL9TtGmxuV8f9R7yLNP4i8j0BOGe8eKhACh1eXiGpgBrpUgaDsVZf7KBMryrnEJWXyYNh0ZuRIG53dfzvk2B74hiu+D74L5uIOQIlrH0FAQH1Xu+q9Kv9QGbPn3din1JZKAXI9o6WclPjldIeydy7GNL1sfTcr0KJehLl0Je+IbTDTSNItAlIawydj+0R3CqPiIcSb6rsX7dYtTeOPQt8ezfUZaQSzWQEjW6PbsUGy3+hGm4VTmmBvsab3XoEW51HMZZvpE/e62EFgZcsSKwLHRdSdrAXiPO0PLoloY+X7/JAQP5766wvEl8z79uUtODqNvU308RoEqHj4ebsStaKKl/jLSRIKuq4KuAJBCEa2TG+tdWX/2kdRjnyeG2HUkew5ROGv/5bajjcxcUwuxypR0MUxRAGqubtcjyPXVis/UA+u1Gem+nVeHWt41ObE2EYKyXpo/xQbAAGUfbnBmdx7pg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(44832011)(5660300002)(8936002)(2906002)(8676002)(4326008)(41300700001)(2616005)(53546011)(66556008)(316002)(66476007)(66946007)(110136005)(6666004)(6506007)(36756003)(6512007)(83380400001)(31696002)(86362001)(38100700002)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SE5QdWJQeDJDOVhzQnE3ZGdOdlB0UVRWVWVJTGdXYjVPcTZBbUJWQ29vS1Zj?=
 =?utf-8?B?UGYxNGFZOG83OE9KZmpXeW56Mjk1VjRnSG1UNE5oeWhkeUQwdU42aVBmRWZQ?=
 =?utf-8?B?c3FrZHFiZ3ByUDd4QnJrQmxmQ1FwUFVEalhJS3htTjJUVHlzcEk5KzB1dWlX?=
 =?utf-8?B?cW5MNnpSaEN4WGxCUlRkZ1dubWNKR1ROcFVRZVlqMzJvN1BXTzNBRWttcU5I?=
 =?utf-8?B?Q1FYOHB5clZIZ0tETkhtYlZDSGFHcW1FNXZZaEx5emlvNHdDNzZrdDlIc2Jt?=
 =?utf-8?B?MXkzbWhzZDN3L2JXWk1RYm9UUG8zOXdsTzN1RzEwblRieWZoNy91QUNiRXo5?=
 =?utf-8?B?blNKRU4weHgxY1AxMXVXTlRsUFV0ZDZoMHNTYUl5TVRndlVNL0I0aTdpVGNw?=
 =?utf-8?B?RCtIcUpLK0djVWtEK283ZG5wdnkxWS9VaThvMHBNYWxSOGFFY0RJSzd1enpQ?=
 =?utf-8?B?RG94RWFCenJ4dGMxdzZ1Um1QWWR3T1BtNkdnYVlqU21ENnJVMDhsbklTam1Z?=
 =?utf-8?B?UjFKTlZ5YlhjSXJxYU83aVB2QVNyMVlIM2w0UUJTRlRMNmJTejF5d3ZranFt?=
 =?utf-8?B?UWNjWUIxakw2QWJhZUJXVWFiOHFOZEZtckZteEpqT0l3N3oyNnM5b0owejdS?=
 =?utf-8?B?Z2VOVW82OGxiY2p2b0JLN1JhSHpvME5CNG1ibGFmNXpFYWdhQjlaeTdUNndM?=
 =?utf-8?B?TDlzR0k4anpRSkxoQ0l4czY2K25oSHptWENSMU1OM0hRa2RoWVorTXN0Q25W?=
 =?utf-8?B?ejduWXZrQkRDa3B0Wm5qc1NhaU80cGxMQmt0cnlIaXNoQWRCTVJVUjJCSmNn?=
 =?utf-8?B?Nyt1N2xWaHpuN09xZW1MWi9LT2dLN09xeGhvaU5LWHFLMHRCamJoV3YvUWZV?=
 =?utf-8?B?MGFjeHArb2szMkhoSGd4MnQvQnNoZEVmYWhsKzJOa1ErbS8zbTRxdGtHL0l6?=
 =?utf-8?B?UHZTdGxjaTdLdEsraEtyTEk2bXhDWmhlWlNVaHBxMjlib0ErNmFJMHZUT2VZ?=
 =?utf-8?B?RUNJcGdRSmhZRXNaNlZ4cHJaNEVWREpOQm5Qd3FzQjZuRFVUTWliNVc0OGU4?=
 =?utf-8?B?OTV2UVZWbzhSRU5MMGQwbzhzcG5RNGFLSXVjWm1CUnN0OXBmME5MZEE3R0k0?=
 =?utf-8?B?TGJ1bHNSamxMRHRON3I3VTVoS2RPUmFPdS9MVnlKSjBtQ1h4Sy9PVHdvMDdB?=
 =?utf-8?B?Q05PL0V3eDJ6eWdadWJaRnFqdThQanB3VERqS0p5NmRaNE5VTzJLaXEyNERx?=
 =?utf-8?B?UE4vNW1yY25XNEZULzdsZ3ZuTm5vK2JzUG9oZjhYZVVub015THBaTHZSOG5n?=
 =?utf-8?B?L2I1V2dObDBmYVdydUtCanduSm9URU5vOVVCZlVMSThHblpnc2VvU1k3K2hR?=
 =?utf-8?B?MFBOMXdTZk16cVpDSnI4VmF4MUcyaXl1a29IcUxQNjZaQ21hKzcvY1JwMUs1?=
 =?utf-8?B?cHdNbmozbmtOanRlZkdGWDBHZlB4L1RLWGEvMGlpQ1N0Ry9nQW1YUWtkN3NC?=
 =?utf-8?B?amw1TjBPZExlVE9SUmk5b0d2b2RjTmg1RTFEZXRueGlmZjBBUjBtRE9VRHNU?=
 =?utf-8?B?YlhlU0dpVUl6SXVieHJOYTB3dHNaaUJaT05DVUx6VE9LK0FBbGd4N3ZuQVV3?=
 =?utf-8?B?OUs0MDhYR0hTNll6REdlc3VKRk11Q0xnT1Ivc2ZHZEhzdHI5NXFHM1VTZGNS?=
 =?utf-8?B?Q3NyYWNWLzBySzU5clloQVRuMmg1N01XSm11MzBVeGUraDRNL29aMmo4U2dS?=
 =?utf-8?B?NmpoLzByU0F2ellPN24yeHdxV1hJbFpjc2RHOFhWQUdndklWYmNhek1zaERL?=
 =?utf-8?B?b3VvVlRJd3NndHh6ZUVOOGZMblVGNGNIdkp4eWxDdDlvQXIwck9TVjhYTUs1?=
 =?utf-8?B?QWM0WGgrcDRicXI0aTYvdWFOUlkvYUZjZ0ZKOVpNSFltYmpJbmxjd2c2TEdO?=
 =?utf-8?B?Tjh1YjNKc3V0emMyU0pEMzFuRmpvWFBER2JLTWJ4Q2dMVHNjTTdhRGVLRmpk?=
 =?utf-8?B?R0NIRkpGc0wzK2JnaHJjSmNLWHk2M0xZVTV1bmswTVgva3VlbUNoc0hzeHZ4?=
 =?utf-8?B?eXNTUHhHVzlTZUhoUi8zOXg3Z29LT1hyVmliNEhZKzJnck8raFBWcXptYU56?=
 =?utf-8?B?SFZsYndBRm5McVIwOGJ0NWp0SjRkUmtNZ09FVnZXRlBGT0ZhdENWd2VCTysz?=
 =?utf-8?Q?p7VHJUftA9dHYQ44MyQXg4Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vJRHlyoFBYD+zyzDkHseOSD6NVql9Y6D1L0169rFfdE3XqRmNyUA58MAh8rRdBcOENM7O+re8ATGrrfAqBD59plJ9Lm+Kya2lEpvhDQzjrZSaZ7Tp5KzUE3f0SshfuiOyd5M5HUJh0E1c1egGsPX3Wwxt7090C0HXlPzSbB6xLBzZSI4RbP7EY/cUHzx+UNjODPalJzNc/OlEaZaL3rKXabFg+v/jC2sOHBcyP5yS4GlHoxTrwcJzL0UQlhhskDgRzPEZXujYoJjKJx3zowRZ+j0mL3q+pBW+yRH68IXWR7u3ESmAnIsE1XIWtkzgzAQfINoxsrRV2MQTM+Rbsj6j8QNsjbrIhZmPYCtoc6mo3TV6mto87uCA/9E3xX2NI4Enxi47AmC7M4rQar1bWBu+UbuZRe3kyVxJ4JctnIaVvAP0ubrZe+e0velNJ3qElE4GoWdwbqShGHv4ljqEvkvmtDW9Dy7gXZhn6BbzIP32n2P6pURe6SUqkxxRzaXuOHL8wGbNYciPJalIMfmAz39h7KiRfu/cBJFmicrLRtnHupF+QEpRgAlR5JQr/Itwd0OykSqevyOW6+oVabdqoRNvlupAO1zSKl0T88gaYfsvSx8JH6C9Rg/Qa7jMx5uuuAnKtbLCBKtvPtmnmxo5pmq9QJIYNm8CHTsF9Nd7VpmKItBFB1vjXhvA8MxaSO9O4UQ9aR+noq9o4KAeusgf2evBhqpFSDAOYuxTGJxj+qE6hfEDMEfkR1BfRmGGwoQ+TemjEjZO+Z+nHjxbVYNSXS5o7HRhtC3+dDvdtFaoyzl6B2F3+N4Tjl3w8cmvI1Q8PmCyRgsNOjrFf8l9VFhDtQmMjVtWdS7ewFotxaaqipcxETrQ3ldNylBrU+DV93A7l1Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9574a6e4-2708-4fbd-0db6-08dbc5821b51
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 09:04:40.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngc+xIK85a6zahtVxNZCz6HDUJozbrksPjszNeLklAyJB9QZ0WfBMTu2t6OFTdXJBjNwiUbWHCFjFDxruGfhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050069
X-Proofpoint-ORIG-GUID: kAVHo8C-yh9s2GZvstTCV0frsYKg84_v
X-Proofpoint-GUID: kAVHo8C-yh9s2GZvstTCV0frsYKg84_v
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/10/2023 08:19, Jiri Olsa wrote:
> On Wed, Oct 04, 2023 at 10:21:12AM -0700, Andrii Nakryiko wrote:
>> On Wed, Oct 4, 2023 at 1:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>
>>> On Tue, Oct 03, 2023 at 05:17:49PM -0700, Andrii Nakryiko wrote:
>>>> Add support for building selftests with -O2 level of optimization, which
>>>> allows more compiler warnings detection (like lots of potentially
>>>> uninitialized usage), but also is useful to have a faster-running test
>>>> for some CPU-intensive tests.
>>>>
>>>> One can build optimized versions of libbpf and selftests by running:
>>>>
>>>>   $ make RELEASE=1
>>>>
>>>> There is a measurable speed up of about 10 seconds for me locally,
>>>> though it's mostly capped by non-parallelized serial tests. User CPU
>>>> time goes down by total 40 seconds, from 1m10s to 0m28s.
>>>>
>>>> Unoptimized build (-O0)
>>>> =======================
>>>> Summary: 430/3544 PASSED, 25 SKIPPED, 4 FAILED
>>>>
>>>> real    1m59.937s
>>>> user    1m10.877s
>>>> sys     3m14.880s
>>>>
>>>> Optimized build (-O2)
>>>> =====================
>>>> Summary: 425/3543 PASSED, 25 SKIPPED, 9 FAILED
>>>>
>>>> real    1m50.540s
>>>> user    0m28.406s
>>>> sys     3m13.198s
>>>
>>> hi,
>>> I get following error when running selftest compiled with RELEASE=1
>>>
>>> # ./test_progs -t attach_probe/manual-legacy
>>> test_attach_probe:PASS:skel_open 0 nsec
>>> test_attach_probe:PASS:skel_load 0 nsec
>>> test_attach_probe:PASS:check_bss 0 nsec
>>> test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
>>> test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
>>> test_attach_probe_manual:PASS:uprobe_offset 0 nsec
>>> test_attach_probe_manual:PASS:attach_kprobe 0 nsec
>>> test_attach_probe_manual:PASS:attach_kretprobe 0 nsec
>>> test_attach_probe_manual:PASS:attach_uprobe 0 nsec
>>> test_attach_probe_manual:PASS:attach_uretprobe 0 nsec
>>> libbpf: failed to add legacy uprobe event for /proc/self/exe:0x19020: -17
>>> libbpf: prog 'handle_uprobe_byname': failed to create uprobe '/proc/self/exe:0x19020' perf event: File exists
>>> test_attach_probe_manual:FAIL:attach_uprobe_byname unexpected error: -17
>>> #8/2     attach_probe/manual-legacy:FAIL
>>> #8       attach_probe:FAIL
>>>
>>>
>>> it looks like -O2 can merge some of the trigger functions:
>>>
>>>         [root@qemu bpf]# nm test_progs | grep trigger_func
>>>         0000000000558f30 t autoattach_trigger_func.constprop.0
>>>         000000000041d240 t trigger_func
>>>         0000000000419020 t trigger_func
>>>         0000000000420e70 t trigger_func
>>>         0000000000507aa0 t trigger_func
>>>         0000000000419020 t trigger_func2
>>>         0000000000419020 t trigger_func3
>>>         0000000000419030 t trigger_func4
>>>         [root@qemu bpf]# nm test_progs | grep 0000000000419020
>>>         0000000000419020 t trigger_func
>>>         0000000000419020 t trigger_func2
>>>         0000000000419020 t trigger_func3
>>>
>>> I got more tests fails, but I suspect it's all for similar
>>> reason like above
>>>
>>

This one is an interesting failure that definitely seems worth fixing;
as above trigger_func2 and trigger_func3 were merged it looks like, and
the legacy perf_event_kprobe_open_legacy()-based attach failed due to
add_uprobe_event_legacy() failing. The latter seems to be down to the
way that gen_uprobe_legacy_event_name() constructs legacy event names
via pid, binary_path and offset. In this case it will construct the
same name for trigger_func2 and trigger_func3, hence the -EEXIST.

It _seems_ like a fix here would be to add an optional func_name to
gen_uprobe_legacy_event_name(). At least it appears that the non-legacy
attach handles this case, which is great. Regardless, we can follow
up with some of this stuff later.

>> yes, I didn't say that -O2 version passes all tests :) at least there
>> are complicated USDT cases under -O2 which libbpf can't support (if I
>> remember correctly, it was offset relative to global symbol case). But
>> it's the first step. And once we have ability to build with RELEASE=1,
>> we can add it as a separate test in CI and catch more of these
>> uninitialized usage errors. Initially we can denylist tests that are
>> broken due to -O2 and work to fix them.
> 

Sounds good to me; it's a great change as we're more likely to hit
more problems that users run into.

For the series:

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> I see ;-) sounds good
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> jirka
> 
>>
>>> jirka
>>>
>>>
>>>>
>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index a25e262dbc69..55d1b1848e6c 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>> @@ -27,7 +27,9 @@ endif
>>>>  BPF_GCC              ?= $(shell command -v bpf-gcc;)
>>>>  SAN_CFLAGS   ?=
>>>>  SAN_LDFLAGS  ?= $(SAN_CFLAGS)
>>>> -CFLAGS += -g -O0 -rdynamic                                           \
>>>> +RELEASE              ?=
>>>> +OPT_FLAGS    ?= $(if $(RELEASE),-O2,-O0)
>>>> +CFLAGS += -g $(OPT_FLAGS) -rdynamic                                  \
>>>>         -Wall -Werror                                                 \
>>>>         $(GENFLAGS) $(SAN_CFLAGS)                                     \
>>>>         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>>>> @@ -241,7 +243,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>>>>                   BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/                  \
>>>>                   BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf                          \
>>>>                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)                \
>>>> -                 EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
>>>> +                 EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'               \
>>>>                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&                          \
>>>>                   cp $(RUNQSLOWER_OUTPUT)runqslower $@
>>>>
>>>> @@ -279,7 +281,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>>>>                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>>>>       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                        \
>>>>                   ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)"         \
>>>> -                 EXTRA_CFLAGS='-g -O0'                                      \
>>>> +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)'                             \
>>>>                   OUTPUT=$(HOST_BUILD_DIR)/bpftool/                          \
>>>>                   LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/                    \
>>>>                   LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/                        \
>>>> @@ -290,7 +292,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) \
>>>>                   $(BPFOBJ) | $(BUILD_DIR)/bpftool
>>>>       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                         \
>>>>                   ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)                 \
>>>> -                 EXTRA_CFLAGS='-g -O0'                                       \
>>>> +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)'                              \
>>>>                   OUTPUT=$(BUILD_DIR)/bpftool/                                \
>>>>                   LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/                          \
>>>>                   LIBBPF_DESTDIR=$(SCRATCH_DIR)/                              \
>>>> @@ -313,7 +315,7 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                       \
>>>>          $(APIDIR)/linux/bpf.h                                               \
>>>>          | $(BUILD_DIR)/libbpf
>>>>       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
>>>> -                 EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
>>>> +                 EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'               \
>>>>                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)'                             \
>>>>                   DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>>>>
>>>> @@ -322,7 +324,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                  \
>>>>               $(APIDIR)/linux/bpf.h                                          \
>>>>               | $(HOST_BUILD_DIR)/libbpf
>>>>       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
>>>> -                 EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=                 \
>>>> +                 EXTRA_CFLAGS='-g $(OPT_FLAGS)' ARCH= CROSS_COMPILE=        \
>>>>                   OUTPUT=$(HOST_BUILD_DIR)/libbpf/                           \
>>>>                   CC="$(HOSTCC)" LD="$(HOSTLD)"                              \
>>>>                   DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
>>>> --
>>>> 2.34.1
>>>>
>>>>
> 

