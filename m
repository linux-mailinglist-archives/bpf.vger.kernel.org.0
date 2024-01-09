Return-Path: <bpf+bounces-19255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963F828533
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D389A285B75
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B300374EB;
	Tue,  9 Jan 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YiraEZY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YiraEZY6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oqMn4Luy";
	dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mso/FkRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7E3716B
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C0713C14F705
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704800152; bh=Wx3RjV8+0R+qvQxMS4bMRfByh6VasZLy8vKEQQ8jkO0=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=YiraEZY6Qy+pteXhVuv7rKLBXU4bf6C2F/OPHBPkxP8ClquTJGg7yPgcc5XdU97QK
	 jXGElmn5AdRd2YSZjXWq/TiKVYlW+NEs+jVIkbJFzQf4hjMcm4WXPNkcu7pH7bz5IF
	 xpw01bspLOxO/eL9pfUJECusQo0cwewuzGTFgUKw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan  9 03:35:52 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9F825C14F69D;
	Tue,  9 Jan 2024 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704800152; bh=Wx3RjV8+0R+qvQxMS4bMRfByh6VasZLy8vKEQQ8jkO0=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=YiraEZY6Qy+pteXhVuv7rKLBXU4bf6C2F/OPHBPkxP8ClquTJGg7yPgcc5XdU97QK
	 jXGElmn5AdRd2YSZjXWq/TiKVYlW+NEs+jVIkbJFzQf4hjMcm4WXPNkcu7pH7bz5IF
	 xpw01bspLOxO/eL9pfUJECusQo0cwewuzGTFgUKw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AFB68C14F6E9
 for <bpf@ietfa.amsl.com>; Tue,  9 Jan 2024 03:35:51 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=oracle.com header.b="oqMn4Luy";
 dkim=pass (1024-bit key)
 header.d=oracle.onmicrosoft.com header.b="Mso/FkRU"
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ccw8LwbcEOQA for <bpf@ietfa.amsl.com>;
 Tue,  9 Jan 2024 03:35:49 -0800 (PST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 850D8C14F6BA
 for <bpf@ietf.org>; Tue,  9 Jan 2024 03:35:49 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409BU5W4019009; Tue, 9 Jan 2024 11:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FxJRWlZa3NhCW+rI7YdR7U0Spj8fTUcb1slT+OPM/pU=;
 b=oqMn4Luy1kc/EmHftMCjC/2subqibYK6LCN5RQZuGEtAA9/w19WYmYBvdQM/2QOBRGTM
 S/r+B8EPqeo7GjcxqP70/Q/8FwoNg87MuPsRStLJKhibBHHWWSbEhJbMWY7Km2xHM2AQ
 Wi7uczAxr3mEvB4VKdRx8VCeC1Gz6VY1YakY0HZu+BIMro4sq0+mJp+d5gJ0KrDr9Pp8
 cBZJrqzzDxJud6wHQgyXq1zvCtaFwz4tcGdUWaPUFqYP3EynCA+ov9yGw5Hh3/J7Jym+
 1nvcXu+JidwXW9AP/aOMjik1r7L1H5N76Lysm6JeHA3gyVZ7L+44Fg3E/gf+PeZHzcYD pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh5ap806c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 11:35:46 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 409AUGxx006678; Tue, 9 Jan 2024 11:35:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfur3m62e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 11:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUgjTOPBEw3nMkY5KrS8DuuvcspcVRNWzFSkvEcQq1Gxb5GWCx8BaiRfptCMH/K1ZDmYmg0ttTT5ZhytBJTZJuIJTmv6Dpj2FVpsolDyaITLeSuQKIimXsrEKYz0dUt5HEgcOyXXXdPqtZhUlEDbx6GXr6vEpCT0c3Aq+cpU1MbbwxIrmCnSvceKqU79OvpTyCGos0PQnO7Ic3Lpz5dlMBMcfccWeaOZYoCUqYF1WbEGjemef+MTTXh+BBWrMlujb66qUJN4YcRifnsXTjdv7w5PM5qBBe1J1A+y2eamYmJ0N7xYSLnKAARKzrovga3PDEGsEjc8+a7SwViyLErizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxJRWlZa3NhCW+rI7YdR7U0Spj8fTUcb1slT+OPM/pU=;
 b=hMy2dVenOE27+EvIAECMRbI94+O38Ogw5I6fb3ez3mI16hCIefAr30bwmNQGKuSiVbD1aDiPXUUv9NzVGCffJ+nNb//lL7jW+9cxCBMM6qym15FALQ8eC0RR+ykmpaUIFreqthMp1bdyNvNApEZySaPjJfcPCyAhkLBXXpZndBOChsc8u+sQsTVB5raZRSj5zNng08OUshZvjOK6xE6HGCZfnFZaM3dOKJL4vSx3pGdXWw/7+u/M+edJ7wUeaBiKfIBPJNeiECLt9iuUJk1VqOBar7MiaP9AWShVCFdW4f8T6SXkNkdL8NoDBH8OM9y/VmhgFJwNsRy5kDbvUNowMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxJRWlZa3NhCW+rI7YdR7U0Spj8fTUcb1slT+OPM/pU=;
 b=Mso/FkRU0UcyLeytzIP0sOo+Llom9bOa+PCu3fNpp0nFyugqZH7tLwaxUGluPUeeC1RmLmVXuPcaRMJiJ5bMKEDbX4RmjiamjLCL69TsDlkjwocClhMo06WpfIt3q95MpvS2jEMmJMYSC99Se0YlCC2dZaIMIY1vJ0UJjxoWrXM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 11:35:43 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 11:35:43 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Vernet <void@manifault.com>,
 Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 david.faust@oracle.com
In-Reply-To: <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 (Alexei Starovoitov's message of "Mon, 8 Jan 2024 13:51:21 -0800")
References: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
 <20231213185603.GA1968@maniforge>
 <CAADnVQLOjByUKJNyLdvDzwuegtjZFwrttHft_1o8BoyDCXQvDQ@mail.gmail.com>
 <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
Date: Tue, 09 Jan 2024 12:35:39 +0100
Message-ID: <874jfm68ok.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f89414-8b75-454c-d39b-08dc11071d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7OlMmTUDLDenmIeeO8FznNAR+YruBEypkT5EwgFsvPD4GRYDL+/AWoEM11HY152wRxfjKJM68i7Gd+XG9/e8IGv0Nd48EILkovU0wAszMe+y75BeSBNqp2yq3p9/F7zGv5Pxk4jkRFb4AP3+vc8PtEcrgqTFCaIK9vNtvL0zCKjMrLJXyNyp2K3AjLhkWzFxdfZbBq1P7truAlLq4BobyPfsjmm5t1w6oUU2V+HacVe17QinD2R47FRvrv9OscRT8wlO2dUmxGnkNKmKAUBwnHUk053wvh3bI6A3gCkrIFKuM2GIDLfTbGhYuIAuhJS/PJvKTfVMh9RwdqmAAXFh4Bv2iopDP1aTVAtCoGPSgmiw2TydIjlGYSPHbzj5srpqZchiiS/3UR81Eu5JfguuS/hGeE9wqLvNqWfm+S14r9+Y6hdJ/Fp8tkk/e7y7AivesMq0VsC7Nw23//TRS5Zt7MMejl51rnajMEQQ7NU41S3Tkyb4JYwkH5hLvj4enUm3rAYDA9gtIBhmuXjyf7CWllTLMJuSpe/3xcc0mbJlrvNa414H4xxICmb6lN5ve5q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3113.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(53546011)(6512007)(6506007)(478600001)(6666004)(6486002)(26005)(38100700002)(36756003)(86362001)(2906002)(41300700001)(5660300002)(107886003)(83380400001)(66946007)(6916009)(4326008)(54906003)(66476007)(66556008)(316002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBNUThOdjhTQ2pxQnNuSktJeCtsRFlTa1BEM09FdmpHL1FGazNRNGkwOG50?=
 =?utf-8?B?YWtQc3JRZHVZZVdPUWxkTnJLRnB1UEY4cDN6b1huQS85NS9uUVQ0TlFLaS8y?=
 =?utf-8?B?Nk1kYmRna1BPOGR1ZHd2dkhyd3VnU2xXSGF5WWRhbjNXV2c1WDRjV3k2T2hs?=
 =?utf-8?B?U3NKcWgydkJWakRwM2RNSml4cUdXSzRzc2hmdmtpSUI5NllMS2tzYzUyYkxJ?=
 =?utf-8?B?d0xtOWZLQzFzZjhibEVVSkV0dGpsQzlqY05HOFE5NVM4SDVCRjhiL2UwQzNH?=
 =?utf-8?B?UWppcVkxNzRLOEN3V3V2bjUrVlRUSzcxYUhmZUg1ZTJwZVpGMVYvODgvWUhj?=
 =?utf-8?B?S0xYUVVMWW5XclJZeG5LcGVyUklOTk1NS2RTZVI1enh2UUhUTzh3UEdpcFZ1?=
 =?utf-8?B?cWhsKzdWSGs0ZnY3NDAwV2F0V2Q0aHJVSExxakJvSnN3ckVHdlBTd1E3eDNn?=
 =?utf-8?B?cDZLc2FWWVU4eUZ0Uy80NkpjcGkvajAwalR5NUI4THFvNDVGY2ZaN1czSVdo?=
 =?utf-8?B?RXhaalZ2eVFWVjREaU9ndEx0VEpaTVFyVlJhRk15eS8wNlEza1lvRHE4VFk2?=
 =?utf-8?B?WUVCQzlRVTg3d2ExL1pWYW1DYXN6MS9TaEMxVkpubzRhVldLTnJ3YmVNVkRx?=
 =?utf-8?B?bWF3MWdSMVZ2a3FCOStSMENWMGFDaGp6ejVKWHdFWHlDS0pXbHhYMS9hd1Iz?=
 =?utf-8?B?aHU3TjRyRDZYdGMzdEFXU0NiZEx1dnBtWDN4VENWY3NBUWtCdkMyQ3JGTkZT?=
 =?utf-8?B?VEJ3SHhnYW5DSGo1a0hMbXZIV0pIVDQ4MDBzWExSTGRYL0tKRFNmOGNTZjg1?=
 =?utf-8?B?N3pvWEVwOG8xK0pEazN6blBoeXJOZHJYT0hiUGs4ajV3TmVic2tyaWpZRUE5?=
 =?utf-8?B?SE0vWlFSMXhDdHdmNkVzeUNkdENQaVEreDRLSlM4L09Yd0RvVDBMMmJxMUxk?=
 =?utf-8?B?cDNrRi9FUTBWM0ZKcFpGc2llUkdGaUFseXlOVGJDdXpEZllTZ1phK2llNVgr?=
 =?utf-8?B?SmZ1SDJBZEx6bnlXVC9IYmluNEJPU2lhMUcyT2VYT09sRUNYVEEzYnZhWU96?=
 =?utf-8?B?Q21weE9UUndDYStxZDBBbWEyQ09KaEdTb2kvWCsxNTBhV3JHRGp3ZTIyK24y?=
 =?utf-8?B?UkZ3WS9VWHlaMzcxZWU3NkY0WHJzWU9jck83aGZ6QVpZRmpuSUhzdGIxcG5w?=
 =?utf-8?B?RzVHZWVMSnJteFdkbDdoSURDOGdZZ3BIMHNuZjB0a3ZVdmxIWjhMT1RxU0pw?=
 =?utf-8?B?NkkwOU5uVmwvS2xjU0NwOTZGRWxIQWVBekxaamtMdzBWbVVETVJDNDgrWDZq?=
 =?utf-8?B?OUJ0N0tZM2dhMFRCcVF4ODd4aFNuS2dlRGR0dVY0TGg0MmFtZ1llWGFMWHZM?=
 =?utf-8?B?YUQwb0o3S1lVU0FFTkRvOEVQTkxVTUJIVzNobEk4UEVNMm1QZFNJcDE3TFBH?=
 =?utf-8?B?aHMwQSs4N0VqbGRRR2hDdEFrZDNrNXVPb1VQMnFTOFJFRFA5TmpEMmpRbUJy?=
 =?utf-8?B?T1ZXQk1Ib0xncElJUXgzV2RsUXllemt4eVZzZWZRZGkxZW1FcnBmMVprbGR6?=
 =?utf-8?B?cmZ5WGVIZm9WejhtYnRCdkp4Y0pkWk9ZSXo3QmJnRDYxOXZteVo2SDlnL3Yr?=
 =?utf-8?B?cVlLR3NBOW1mSzhNUmhoSVBZYUJBQ0hleW4xOXlOeXM2TjJXZ0tib1dRclNh?=
 =?utf-8?B?VjBpNlNSMEdPMzJXdWtuekpzdXRRRlVnN0UvdllhWWU4cWVKU0tEQ0p3MnJt?=
 =?utf-8?B?VFNNTTkvT3BRV1NkZ3czc29yNmJSM0tKZElXeVI3c1BmcVd3aFBvdXRmbHVp?=
 =?utf-8?B?eDBLd2JhNVZVK01BRjVISkx6djdsVlAva1Vua1d6TVJYVUNsalpaczR6dlRM?=
 =?utf-8?B?elNjRjMyTmFacGc2M0hjK0xQYUV0WXhFZng4YklLVGR3ZFQ4REM2a3pnR1VG?=
 =?utf-8?B?NkZ2SUNhcUhkUHpYc1Q4clZiUnl6cGZwV0JzUUdCM2MwQXNRbkJ4MWZrRm8w?=
 =?utf-8?B?RHVRdk0xbHF5TkI0STA5cHM2VkFrNWZqS3lzcHNVbDVycDZFOHdhVzIyTzJv?=
 =?utf-8?B?eEZMOUVXWkZkRGRZMG1uS2c4Wm1waXZCSXF3MzVKbU5WTGNDRkw4RGlhbUJX?=
 =?utf-8?B?cUhVeUhqL0QreUdUa25YUi9Pc1QrdUZJeitBZzZNWHJaRlJlbU9TM0dINXRI?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tzf3e19x/ktoB8zaYuBU0zxtmha1QuX3x21rx39TsrsIL1wrRfj7GrKQtzuqDfwEhBk3f0qwMFEnv4Zt+ui7vnD6vWkDqiB9oKgjKlzkuT3+0FyE5N/ag6Q3E9Lfd724fWAEjairyBa09bHHI6OiOseeT+/RjqwFk3cD8EbQzKmT3Voawm5xoCo7Af2T9VIWJ55Lt5Z3zBjawTmqh/QKfV7JfYGZEpp6YJ0A+DRLULXODmPERbf5b4kXBIvnYfqjjRnOEQGp7dHl3jM97KDpigdAd1bGkLuYuiOtcQRPRrvOS09G8niERhKpyM+hClUksWb1dDOL7N62BtbjJ/wnSS6EY6x+wTNDAh0+E62a+/Scmd3DBSS2MCks82EgmQRZ765DDnZ2iERhROiWw6XnRoXFzgs5yAu8r8jnc5rctnh3Ng6ArGz24pErVNxSVqWUBj8rI5qpP5Yaqtl1rtHXxoEVVLcuLKYqWKjLHiF5bTy4NIkEUkm1as3sGKqIluo5UjSfjz4LP4BC0mk49zFJEJiPPUPez2c0ookMXbO8acvav3O6Pv+DTR5oAkYnfOtMjmGlXXSvDSF9uIX6XFwi65lmSdJfnJYaU8vm1ZKu3dQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f89414-8b75-454c-d39b-08dc11071d2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 11:35:43.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5loHvNuVVx8XWXGjOnk4VYbDPcj4KhZJqLPVSB9A6neBUNN2BD6fWwWxITDaxE/6kTMs7pPIiH9GJSPEKS7aIREE5eFD48j71zDuIsbDmNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_05,2024-01-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=768 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090094
X-Proofpoint-GUID: 1to4uEYwqQoS-QN8kDjl_t8oKSgPzbnR
X-Proofpoint-ORIG-GUID: 1to4uEYwqQoS-QN8kDjl_t8oKSgPzbnR
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Kg57MpbS-4jjPEY4l7dYQhrTmxI>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

Cj4gT24gTW9uLCBKYW4gOCwgMjAyNCBhdCA4OjAw4oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPj4KPj4gT24gRnJpLCBKYW4gMDUsIDIwMjQgYXQgMDQ6
MDc6MTFQTSAtMDYwMCwgRGF2aWQgVmVybmV0IHdyb3RlOgo+PiA+Cj4+ID4gU28gaG93IGRvIHdl
IHdhbnQgdG8gbW92ZSBmb3J3YXJkIGhlcmU/IEl0IHNvdW5kcyBsaWtlIHdlJ3JlIGxlYW5pbmcK
Pj4gPiB0b3dhcmQncyBBbGV4ZWkncyBwcm9wb3NhbCBvZiBoYXZpbmc6Cj4+ID4KPj4gPiAtIEJh
c2UgSW50ZWdlciBJbnN0cnVjdGlvbiBTZXQsIDMyLWJpdAo+PiA+IC0gQmFzZSBJbnRlZ2VyIElu
c3RydWN0aW9uIFNldCwgNjQtYml0Cj4+ID4gLSBJbnRlZ2VyIE11bHRpcGxpY2F0aW9uIGFuZCBE
aXZpc2lvbgo+PiA+IC0gQXRvbWljIEluc3RydWN0aW9ucwo+Pgo+PiBBcyBpbiB0aGUgNjQtYml0
IGludGVnZXIgc2V0IHdvdWxkIGJlIGFuIGFkZC1vbiB0byB0aGUgZmlyc3Qgb25lIHdoaWNoCj4+
IGlzIHRoZSBjb3JlIHNldD8gIEluIHRoYXQgY2FzZSB0aGF0J3MgZmluZSB3aXRoIG1lLCBidXQg
dGhlIGFib3ZlCj4+IHdvcmRpbmcgaXMgYSBiaXQgc3Vib3B0aW1hbC4KPgo+IHllcy4KPiBIZXJl
IGlzIGhvdyBJIHdhcyB0aGlua2luZyBhYm91dCB0aGUgZ3JvdXBpbmc6Cj4gMzItYml0IHNldDog
YWxsIDMyLWJpdCBpbnN0cnVjdGlvbnMgdGhvc2Ugd2l0aCBCUEZfQUxVIGFuZCBCUEZfSk1QMzIK
PiBhbmQgbG9hZC9zdG9yZS4KPgo+IDY0LWJpdCBzZXQ6IGFib3ZlIHBsdXMgQlBGX0FMVTY0IGFu
ZCBCUEZfSk1QLgo+Cj4gVGhlIGlkZWEgaXMgdG8gYWxsb3cgZm9yIGNsZWFuIDMyLWJpdCBIVyBv
ZmZsb2Fkcy4KPiBXZSBjYW4gaW50cm9kdWNlIGEgY29tcGlsZXIgZmxhZyB0aGF0IHdpbGwgb25s
eSB1c2Ugc3VjaCBpbnN0cnVjdGlvbnMKPiBhbmQgd2lsbCBlcnJvciB3aGVuIDY0LWJpdCBtYXRo
IGlzIG5lZWRlZC4KPiBEZXRhaWxzIG5lZWQgdG8gYmUgdGhvdWdodCB0aHJvdWdoLCBvZiBjb3Vy
c2UuCj4gUmlnaHQgbm93IEknbSBub3Qgc3VyZSB3aGV0aGVyIHdlIG5lZWQgdG8gcmVkdWNlIHNp
emVvZih2b2lkKikgdG8gNAo+IGluIHN1Y2ggYSBjYXNlIG9yIG5vcm1hbCA4IHdpbGwgc3RpbGwg
d29yaywgYnV0IGZyb20gSVNBIHBlcnNwZWN0aXZlCj4gZXZlcnl0aGluZyBpcyByZWFkeS4gMzIt
Yml0IHN1YnJlZ2lzdGVycyBmaXQgd2VsbC4KPiBUaGUgY29tcGlsZXIgd29yayBwbHVzIGFkZGl0
aW9uYWwgdmVyaWZpZXIgc21hcnRuZXNzIGlzIG5lZWRlZCwKPiBidXQgdGhlIGVuZCByZXN1bHQg
c2hvdWxkIGJlIHZlcnkgbmljZS4KPiBPZmZsb2FkIG9mIGJwZiBwcm9ncmFtcyBpbnRvIDMyLWJp
dCBlbWJlZGRlZCBkZXZpY2VzIHdpbGwgYmUgcG9zc2libGUuCgpUaGlzIGlzIHZlcnkgaW50ZXJl
c3RpbmcuCgpTb3VuZHMgbGlrZSwgb24gb25lIGhhbmQsIGludHJvZHVjaW5nIGlscDMyIGFuZCBs
cDY0IEMgZGF0YSBtb2RlbHMgZm9yCkJQRjoKCmlscDMyCgogIGludCwgbG9uZywgcG9pbnRlcnMg
LT4gMzIgYml0CiAgc2hvcnQgLT4gMTYgYml0CiAgY2hhciAtPiA4IGJpdAoKbHA2NAoKICBsb25n
LCBwb2ludGVycyAtPiA2NCBiaXQKICBpbnQgLT4gMzIgYml0CiAgc2hvcnQgLT4gMTYgYml0CiAg
Y2hhciAtPiA4IGJpdAoKT24gdGhlIG90aGVyIGhhbmQsIGNvbXBpbGVyIGZsYWdzIC1tMzIgYW5k
IC1tNjQgY291bGQgZGV0ZXJtaW5lIHdoYXQKaW5zdHJ1Y3Rpb24gZ3JvdXBzIGFyZSBnZW5lcmF0
ZWQgYW5kIHdoYXQgQyBkYXRhIG1vZGVsIGlzIHVzZWQ6CgotbTMyCgogIFVzZSBpbHAzMiBkYXRh
IG1vZGVsIGZvciBDLgogIFVzZSAzMi1iaXQgaW5zdHJ1Y3Rpb24gc2V0LgoKLW02NAoKICBVc2Ug
bHA2NCBkYXRhIG1vZGVsIGZvciBDLgogIFVzZSBib3RoIDMyLWJpdCAoaWYvd2hlbiBhbHUzMikg
YW5kIDY0LWJpdCBpbnN0cnVjdGlvbiBzZXRzLgoKQW5kIHBlcmhhcHMgaW50cm9kdWNpbmcgYSBi
aXQgaW4gdGhlIEVMRiBmbGFncyBzZWN0aW9uIGlkZW50aWZ5aW5nIGEKMzItYml0IGJpbmFyeS4g
IFNvbWV0aGluZyBsaWtlIEVGX0JQRl8zMi4KCldvdWxkIDY0LWJpdCBFTEYgYmUgdXNlZCBhbHNv
IGluIGNhc2VzIHdoZXJlIEJQRiBpcyBvZmZsb2FkZWQgdG8gMzItYml0CmRldmljZXM/Cgo+PiA+
IEFuZCB0aGVuIGVpdGhlciBoYXZpbmcgMyBzZXBhcmF0ZSBncm91cHMgZm9yIHRoZSBjYWxscywg
b3IgcHV0dGluZyBhbGwgMwo+PiA+IGluIHRoZSBiYXNpYyBncm91cD8gSSdkIGxlYW4gdG93YXJk
cyB0aGUgbGF0dGVyIGdpdmVuIHRoYXQgd2UncmUKPj4gPiBkZWNvdXBsaW5nIElTQSBjb21wbGlh
bmNlIGZyb20gdGhlIHZlcmlmaWVyLCBidXQgZG9uJ3QgZmVlbCBzdHJvbmdseQo+PiA+IGVpdGhl
ciB3YXkuCj4+Cj4+IFdoYXQgd291bGQgYmUgdGhlIHRocmVlIGRpZmZlcmVudCBncm91cHMgZm9y
IHRoZSBjYWxscz8gIEkgdGhpbmsganVzdAo+PiBoYXZpbmcgdGhlIGNhbGwgaW5zdHJ1Y3Rpb24g
aW4gdGhlIGJhc2UgZ3JvdXAgc2hvdWxkIGJlIGZpbmUuICBXZSdsbAo+PiBuZWVkIHRvIHB1dCBp
biBzb21lIHdvcmRpbmcgdGhhdCBoYXZpbmcgc3VwcG9ydCBmb3IgYW55IGtpbmQgb2YgY2FsbAo+
PiBkZXBlbmRzIG9uIHRoZSBwcm9ncmFtIHR5cGUuCj4KPiArMQoKLS0gCkJwZiBtYWlsaW5nIGxp
c3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBm
Cg==

