Return-Path: <bpf+bounces-11879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C387C4E99
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9257B282364
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B901D1CF96;
	Wed, 11 Oct 2023 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XRbjJ8oS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DHIxUfRM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4365E
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:27:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9794
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:27:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7mdmh022660;
	Wed, 11 Oct 2023 09:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a6HCXeE/jgL0IequrAooqFsmy9EpUs1QJ3xoa7IhJvI=;
 b=XRbjJ8oS9ZOeRC0+Pv9WbETt4nisJqVirGNh8mpxnBCTb/LL9MCTZVzPuIYaAW2J+OGl
 VS7UZ0ZIs8bjftNr5y8zaZuXw2xidw1dQ5T/77skN/IogWo3azgZrqHX0EEEyssk9FZ+
 Nxbls/GBFvNRnlDBNBSEnIGhW9+fRPh9z4k69L+aDfBW89jjhETvu4pbaM5+J4t0DGGr
 VU1FoWG60qJdvQkdn5DQAymaVB3SCljn6qVEvvnemjTvt4EEtLDFpfHKZtnBMYl2UnR/
 m744ludiRkWXLC5R4QRXrbi3LlQoyu8+5W0BfRogmr33MWMAZ8SUwuXm4eBIOVUDn9H5 ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43qcuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:27:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B80rVZ015092;
	Wed, 11 Oct 2023 09:27:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8dcwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHaVQe8KmLT0GlNv/2F1VDYRr1s+OXdMm/+ybyZ0FHfkXS4Afq60UcTpy7FHXk7GgkgiilnpEQA+RzL9FNzA92EKGLNhgF0HxR5W4Iy0C7NK6+QnjalCW1ruJWdRaMr6Z6l3F6KHnTX1co3Ye9bq2qFNe+sz4mUpctoMSIaS/LRdTAVjL0MPj7lC+xFozOSG69evg3//jrE+3GabEJSHb06Ni4eyMMiiuZsGQe1h9ILnASGC0QTMmRpjkcbNkRrhw/eKgpZQe29qnCHNiofcejOzxiPKGIRFXEcMHibxxhx5wPMQBp5vG8uXhUsgmN6TjkHtNqt00GFIM+p8gezLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6HCXeE/jgL0IequrAooqFsmy9EpUs1QJ3xoa7IhJvI=;
 b=Y1EgOzfy0O3S5rJ0QdMqz0jBg7ZFi3N4oLa+B3QKZ9h79sf4f6x0IcCoFBrZIKy3t4XkWZYzyihpF7Cy8mYSRB/wuub5ow4mtppNldMtlj7XJPHYigzdvXdk+YOA8LuJoT8lgEej0CEmgL2uQbxzmtR6Zj7IMwiyiDtr8PvauAvKmrAfnjXQCjyMfSZOJxUlwTBtRi7F05ZjpV/2n2j615ABjVHp1u5CFHAGLNNrTohTtMmT6dwMdbNfH2SrxIKZaOzy8Ry4xrUzn8A7moY1CZ8zWetmCLXaalfFrG9DTIfNIEX/MOeK8qnj5Ojc9Pod9THXNJLfc0ckpCFhrc3GJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6HCXeE/jgL0IequrAooqFsmy9EpUs1QJ3xoa7IhJvI=;
 b=DHIxUfRMQDFF2t3I1gcpQGappAxp97jMCy/ke8tTRWh7kFcAAyoDmDo0//Ff+A2FdytM3nzcHLD8rsAoSXi4CpvpTARsbS5fWggT7su2ThZAIiQ7UXJiShrluTi+R4mpY8Rnz8mdkmTPPp7b7yCNN8+nGHaOfAnn9XtmnvetGrA=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DM4PR10MB6062.namprd10.prod.outlook.com (2603:10b6:8:b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Wed, 11 Oct 2023 09:27:09 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 09:27:09 +0000
Message-ID: <1f8485ea-1d0b-dfcb-6b18-c51235bb8ffb@oracle.com>
Date: Wed, 11 Oct 2023 10:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by kernel
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230913142646.190047-1-alan.maguire@oracle.com>
 <CAEf4BzayTrNnOLj4t2s1aegATjqMdvz1iiGq4A6gMmbxJ+zmYg@mail.gmail.com>
 <7e941212-7a2e-5878-6396-cdc6ec39d8be@oracle.com>
 <CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|DM4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 32db02d1-9582-44f4-3e03-08dbca3c3e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n+t5xQOgnSkw++4+qIfvgI0GcEt6HC1x4g8YQ+jt1nWbK3FY/rOIAWwLdsoN4wOPm1PAXomLdYXc3Ow1Q3osdkf2w/DI8vt1ZoDXE3O6uC2BvsUN7GyvRQ04QdLKSuQfyoNi9CRUhzb1mCjYGddqFZXlL2XqbZZFc2Gs5oY09oyX10aawT0gSbPHUEDRJrTGo/4Dodn9Ec4taa7kHyvHw+tZVnTmRbFJ6WeIgvqxItR72Zw8H9/4+89VKdZyNj1W1rqNy3uZiypZU7119IbKWzgjDUeFcPiuS8wxMYxCsJx3KRIm7VpL03RhJk0jlPm4sf45/TZnva7sz4NhJ/O/OirbEgmQKAXBlA3kfxxcNrBY0/aQu8pE6tyNdT9FSe2OxqwazHk5VuWejYRYn42gackvRrNw+8w/3zJLMvJ+K33Gv/pu2YI2Y56BWS9N8KC/xQcILYW4MgVonuRFvwnytdcYzwtzWoqBZmoxsoZTdecheRgb4yJAOwDUli60ZYs2Yswo2/He/GdFH4l3oYaMAjoHS8MNZ077QEK1jQOHMnR0EiCBcZI4ff8idZxBaADBr02XBVQ2m1j+JXUxjnVxClEqIX7kqdPfL8wdj334N9iQ0BD2xiM67NYi2AtGyiLE1iiO93LyDLOwjNTQrbFj6lkwtVl+8G4J+cFaDKDHwHkG35gy9smW/j1sBtNPnxc9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(86362001)(36756003)(31696002)(38100700002)(31686004)(2906002)(966005)(6512007)(478600001)(6506007)(41300700001)(6666004)(44832011)(6486002)(8936002)(53546011)(4326008)(83380400001)(2616005)(66556008)(66476007)(8676002)(5660300002)(66946007)(6916009)(316002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVBlY0x5ZDlPTEhJbmJqSHdUamxkSm5scSs5SnpaTmlBWHpaRUhoZGNGVXNF?=
 =?utf-8?B?SjU4SGk5ejl5cUdGY0JaWlRXSmhzV1NkSGlxWSsyUDBYNUM5bnhVTktoVERU?=
 =?utf-8?B?U0RzS1Y3NWVtYTdialVjcHZld2V0Mk14TDZwZWs3M2lkSlZkUnBxR2pLM2E5?=
 =?utf-8?B?bVlaUC9pSGd0enBreFlrdncvYmw0eUZQQjBaNU1UbUVEbGUwS1dRMVh3YnNn?=
 =?utf-8?B?a2lGVnpGaWczNXE4cFZBZm5SK2J3NzFyTmJLZTIzRUJlUXZUM2RHYzZjc3NH?=
 =?utf-8?B?Zit5N0pVWVhNTjVPWGZCRjFMVXNwMkI0QVhGZGtmKzdJUnowRmUyYkRmSU01?=
 =?utf-8?B?djRmckhqeVRmb0RQTm9xMVpBdDhnaUpZWkdxeDBWWjYrRWVtazE1a21nQ2dR?=
 =?utf-8?B?cEVKcnVobmNrdEt6MlVCa0lHNzRrbU9YVVZqSXIxUXdVWS9HTm1FNFdaUTZF?=
 =?utf-8?B?ek5Md0tmQ0NNRkl6RUdkT2l5RXdiRDlUa0tKLzJncDQwRnZRb3BidU9OUVlS?=
 =?utf-8?B?TFJhdW0yZiticGt6RFBjcEppanNVVE5odVhlQWcveHYrVUROU0lYYlk5Yjhy?=
 =?utf-8?B?ZFVUSVdiNjFBSDdwcWNURmp3VkVzU3FEbnFtcTR1YVBNYzBvMUNJSk1ta21s?=
 =?utf-8?B?QWxrenlvYUxVSzhZblVzTnNlMVVSQXF6UzhFOUpFby9hdWY5eExoTnp6T2Rp?=
 =?utf-8?B?VFRieW5Gb0hvQkpQeTlHckVqUkpLMEtTY0kwSU5MaXcrQ1BDaGhpaG5yNm5S?=
 =?utf-8?B?SzBqc1pCTDhpZHFuS0NtNXZVUlQ2QnN2SzFlZEJmVlNKOVh2bDB4QkZLSndQ?=
 =?utf-8?B?K1hPUWQ1ditlak5JZUpBOEw1RTRaemdNZ2RCRG11Zm1OZ2EvaTJic01kMFFl?=
 =?utf-8?B?UG00KzBaOHhWamhQREVBVFQzV29CZWpHTVlOZkp6cElMOWYrSjAzMjZtNEtD?=
 =?utf-8?B?cFVGQmp1VXlOaWVWTDhPc0VFVStEWnNsZW1YcWg4cjJ2M0tBK3lpWGZxUGpO?=
 =?utf-8?B?Ym5vMEFhRDRaQVUreDJyOUZDMjBDQUZvdEZXWVVhK29iSkJkTnV5QkRBOUUv?=
 =?utf-8?B?WlRMaGVFL09lNXhuUDErdmtUeit0RUVCMFV3V1BwVEFlNWxOSEdaemlKM2Vk?=
 =?utf-8?B?Y1NVckV3VFdVV0IrS0lvNWRaTlR4NHkyR2ZuOUF4MW5VdmpHU0hBNUZVRWxj?=
 =?utf-8?B?a0dHNGIxZUV2Ymorb2dCWWV1c3NVMWhIMkEzcU93QlY5TCtFUnh6cklsZjJr?=
 =?utf-8?B?Nm1Pc3NMbExHLzdWUzBoYUhCSjJPazY4TXRTeU9vdnluUXBZbEYvZ01ieTFy?=
 =?utf-8?B?MjlzdUgwMHhDZ0ladkVmWDJBZ2xTT0lxVmM2d2pLeERzbWNsVzgzVnozd2I0?=
 =?utf-8?B?emZUdDJDalA5MWtFcGZHZ2FOY2l2VXlYV1RLVm4yZ2xVUks4RlNnWkdsU1hE?=
 =?utf-8?B?bmJMQ29JdkpubmlMZ2lIU1RhSEJDTkdRV2h2NFhDT0JXb2YvZ25La01FVTND?=
 =?utf-8?B?cHRCaEEyRy96V2RBaFFud2FoVEhuYW9LN2pPYkt3SVZFR0I5cldNN1pOMHY2?=
 =?utf-8?B?R0JmeW1OZllnVzhWbFR0Q0tLSVVldW1YQUxpOTY0d2EwZ0dyRmh5YlZnc3dt?=
 =?utf-8?B?Z3ZITHBhNWlydWtZK1NRbTZIdzV2M0NPQUF1eDVDNHVvN1JwVFhYRUVaT21M?=
 =?utf-8?B?TzR4bU1IVjhDRGxmWmFCelVkaHJIcDRHdUZhUE9ySDNzZUErTWNRMXgrQWtI?=
 =?utf-8?B?QXZWZnF2c2ZFWWkvTS83OWU3Y1FnUm1mbG9jUWJ3Y1FYVWNYblA0TXpEVkg3?=
 =?utf-8?B?azNJVnBaWG4xSVZibDRHM2FvUzAwR1lHWWg1VDFOdWJGcEpKVW5TdlhWRmc2?=
 =?utf-8?B?ZnFmWFRxWTQ3eVgrdzRYS3FXd2VGbjlEdTBjM2JoYlMwZnFHYnN3RTlPdUJU?=
 =?utf-8?B?czJ2aTJQU3UxeW45bzNvSVhKdHdiZnhrWFNzL2lyeGhpNzBrUDlXdHBxUEl4?=
 =?utf-8?B?SWJQNVl5ZnBRRXEvbGxQU1BtcWZRdDUvZnh1UGpXcFFsVEgyekloNFpURUxx?=
 =?utf-8?B?a2x4QkQzeXUwWDNMbHVVL2JXZ1RxbldBVnc4TDNJVm1uTnVLajM1U2ZUcGRJ?=
 =?utf-8?B?T2J3VWFlVU9od3czMGxmMlNSdDNnWkw5aUU1YmhRczhzekdIRWQ5WC85dVZn?=
 =?utf-8?Q?jk2ucR1s9ieJVgJWWrHGFMI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?bWhDK2QrK2hacXR5RkhkTHZKYlhudEJjQ3llQk41QTA0eTJhOGl2R3BnM1hK?=
 =?utf-8?B?aFYxRjVyTC9kQlZWWTFpVHdnalNhZzRhak9Hby9Bb3ovS1B1dld3aWZ2SjRo?=
 =?utf-8?B?dGlpRURIVmpoUjBjaDl6ODdMS2ZoMEgrMXVrbVRFY0JKalpPbFE0MXYyZzN6?=
 =?utf-8?B?TWcwZEJJUEdOWW9IK2czVVdNRWdXNzIxTzg5UjNhMG5rUWFYY1ZrUUxwTXdn?=
 =?utf-8?B?Vm9mZFFOd09DY0xhUHF6Ly8vTlVwRDl4YzJlMEpsdnZCZHpjdHIxemFDdHNr?=
 =?utf-8?B?aGEyZTlxYlZkTDBYTnNXdWhQc0FMM0U2UGxRckZQRUU2ejV0VDMwNFU5VFZZ?=
 =?utf-8?B?VGFPN0NiR3RBUEpIbEd0VDVwckY1QmhxZDlGMkRjYVIyOWpYb2JUbTN1ZzNI?=
 =?utf-8?B?Zi9RRWRxeFZkazdOVE9zd2h4WFg5RWhGZHNzeTdQWUFhSUFRbDIwWEF3Y0Rx?=
 =?utf-8?B?WlFReTVSdUZlUTNUajArSDlMeFZiVjBYdUdjcTJFVmd2L2NUd1hleHFXOXlB?=
 =?utf-8?B?R3R0emVnUThzTGtFa1pwemhCVzJhdU5vQkZJSUY4VjY2bno4YWw5RW9jTzZl?=
 =?utf-8?B?dWthZ0x4UXplYkRad0oyR0MxMlJNb0xzY0JmeTVUU0xlVFVLaXFYYlVWZnY2?=
 =?utf-8?B?dUx5b240QWZ3QmpnUjVtYTZydnVjbW5mV05ldXAyalNZdlpoU1VuQlNNNjJC?=
 =?utf-8?B?RThxQjJFU3RtVTArOGM1L3NMREcvWmhsOEU0OHZMeTJwdFlWVVQ3VnZmMmUx?=
 =?utf-8?B?ZXFGZUcwWGRWSGtHNFNGUlNtK1VGVlpFb282eTI5dFNSTjZweUVBWGdtMkQw?=
 =?utf-8?B?Yk1XZWo1dkxLSnRDNGswRGVDYUdzTHZTeDFwL1psU0lZTCtqNEVmZDRwaHRT?=
 =?utf-8?B?ajZqajMyWlIvTHJjTk9SSGg5ZXIwOTYxdENrcmcrSlptVzJBVU1yTEdSdVgw?=
 =?utf-8?B?QUFEeXl4RHpUbzdCbUc2MkxZUkNrald1dXNObmdDYkRpNEVsNmVlNDRld3NS?=
 =?utf-8?B?RjNiamtQUEw5L1Mra21tNzU3OUFQOXJWTi9LcGNvVVdMdWtRZWxzTHMwbllO?=
 =?utf-8?B?enJybzg0d3VudnZ6OGJWUmEyUWxtWmNIQ25xcTdacGhXd016dzRlMFdpQ3Ru?=
 =?utf-8?B?alQ2MnovRTQzV3Z4ZHRnTTZpQzZITWtDM0pCYUJyTndCT0FOYXZHWWZrcDRX?=
 =?utf-8?B?ZWh1VVgzdDUzYThEd2NYMzFhYVlZT2ZrMzdkL0MwaXBwTEFHY3dEaDRRb1FD?=
 =?utf-8?Q?cIPtzkizW1J/YiC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32db02d1-9582-44f4-3e03-08dbca3c3e2c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:27:09.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+kH1pf5J+RlOfXpwT4nNHZIGTqtlTIae2GrKLfCUWI5qZ/ZnAHOEf8QadnvZVwLUYZhD3IT5RzFOfjhvPcNzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110082
X-Proofpoint-ORIG-GUID: EWRJ6SEADeuh5c1nvAW-6U5h52oharIA
X-Proofpoint-GUID: EWRJ6SEADeuh5c1nvAW-6U5h52oharIA
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/09/2023 19:58, Andrii Nakryiko wrote:
> On Tue, Sep 19, 2023 at 9:30 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 14/09/2023 18:58, Andrii Nakryiko wrote:
>>> On Wed, Sep 13, 2023 at 7:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> When a newer pahole is run on an older kernel, it often knows about BTF
>>>> kinds that the kernel does not support, and adds them to the BTF
>>>> representation.  This is a problem because the BTF generated is then
>>>> embedded in the kernel image.  When it is later read - possibly by
>>>> a different older toolchain or by the kernel directly - it is not usable.
>>>>
>>>> The scripts/pahole-flags.sh script enumerates the various pahole options
>>>> available associated with various versions of pahole, but in the case
>>>> of an older kernel is the set of BTF kinds the _kernel_ can handle that
>>>> is of more importance.
>>>>
>>>> Because recent features such as BTF_KIND_ENUM64 are added by default
>>>> (and only skipped if --skip_encoding_btf_* is set), BTF will be
>>>> created with these newer kinds that the older kernel cannot read.
>>>> This can be (and has been) fixed by stable-backporting --skip options,
>>>> but this is cumbersome and would have to be done every time a new BTF kind
>>>> is introduced.
>>>>
>>>
>>> Yes, this is indeed the problem, but I don't think any sort of auto
>>> detection by pahole itself of what is the BTF_KIND_MAX is the best
>>> solution. Sometimes new features are added to existing kinds (like
>>> kflag usage, etc), and that will still break even with "auto
>>> detection".
>>>
>>> I think the solution is to design pahole behavior in such a way that
>>> it allows full control for old kernels to specify which BTF features
>>> are expected to be generated, while also allowing to default to all
>>> the latest and greatest BTF features by default for any other
>>> application.
>>>
>>> So, how about something like the following. By default, pahole
>>> generates all the BTF features it knows about. But we add a new flag
>>> that says to stay conservative and only generate a specified subset of
>>> BTF features. E.g.:
>>>
>>> 1) `pahole -J <eLF.o>`  will generate everything
>>>
>>> 2) `pahole -J <elf.o> --btf_feature=basic` will generate only the very
>>> basic stuff (we can decide what constitutes basic, we can go all the
>>> way to before we added variables, or can pick any random state after
>>> that)
>>>
>>> 3) `pahole -J <elf.o> --btf_feature=basic --btf_feature=enum64
>>> --btf_feature=fancy_funcs` will generate only requested bits.
>>>
>>> We can have --btf_feature=all as a convenience as well, but kernel
>>> scripts won't use it.
>>>
>>> From the very beginning, pahole should not fail with a feature name
>>> that it doesn't recognize, though (maybe emit a warning, don't know).
>>> So that kernel-side scripts can be simpler: when kernel starts to
>>> recognize some new BTF functionality, we just unconditionally add
>>> another `--btf_feature=<something>`. And that works starting from the
>>> first pahole version that supports this `--btf_feature` flag.
>>>
>>
>> The idea of a BTF feature flag set - not restricted to BTF kinds -
> 
> so what about not trying to auto-detect anything and let kernel
> strictly opt into BTF functionality it expects from pahole and
> recognizes?
> 
>> is a good one. I think it should be in the UAPI also though
>> as "enum btf_features". A set of bitmask values - probably closely
>> mirroring the FEAT_BTF* . Something like this perhaps:
>>
>> enum btf_features {
>>         BTF_FEATURE_BASIC       =       0x1,    /* _FUNC, _FUNC_PROTO */
>>         BTF_FEATURE_DATASEC     =       0x2,    /* _VAR, _DATASEC */
>>
>> ..etc. A bitmask value would also be amenable to inclusion in
>> an updated struct btf_header.
> 
> I don't know if I agree to add this to UAPI. It seems like an
> overkill, and it also raises a question of "what is a feature"? Any
> tiny addition, extension, etc could be considered a feature and we'll
> end up using all the bits very soon. With self-describing btf_type
> sizes, tools should be able to skip BTF types they don't recognize.
> And if there is some fancy kflag usage within an old BTF KIND, for
> example, then it will be up to the application to either complain,
> skip, or ignore. E.g., bpftool should try to emit all possible
> information during bpftool btf dump, even if it doesn't recognize a
> particular flag or enum.
> 

Based on the above, I've put together an RFC implementing a

--btf_features=feature1[,feature2]

...parameter for pahole [1]. I _think_ it's roughly what you've
described above, and I think it has the characteristics we need
to simplify scripts/pahole-flags.sh (features are opt-in, no
complaints on unrecognized features) such that we'll only
need one more version-check clause, something like this:

if [ "${pahole_ver}" -ge "126" ]; then
        extra_pahole_opt="-j --lang_exclude=rust
--btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized,consistent"
fi

New features would simply be added to the list above without a
version check requirement and ignored for pahole versions that
don't support them.

I'll follow up with the kind layout/crc stuff once we converge on
how we want to handle new BTF features. Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20231011091732.93254-1-alan.maguire@oracle.com/

>>
>> So at BTF encoding time - if we support the newer header - we could
>> add the feature set supported by the BTF encoding along with CRCs.
>> That would be useful for tools - for example if bpftool encounters
>> features it doesn't support in BTF it is trying to parse, it can
>> complain upfront. Ditto for libbpf.
>>
>> With respect to the kind layout support, it probably isn't worth it.
>> It would be a tax on every BTF encoding, and it only helps with
>> parsing - as opposed to using - newer BTF features. As long as
>> we can guarantee that a kernel doesn't wind up with BTF features
>> it doesn't support in vmlinux/module BTF, I think that's enough.
>>
>> Alan
>>
>>>
>>> All this cleverness in trying to guess what kernel supports and what
>>> not (without actually running the kernel and feature-testing) will
>>> just come biting us later on. This never works reliably.
>>>
>>>
>>>> So this series attempts to detect the BTF kinds supported by the
>>>> kernel/modules so that this can inform BTF encoding for older
>>>> kernels.  We look for BTF_KIND_MAX - either as an enumerated value
>>>> in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
>>>> BTF (patch 3).  Knowing this prior to encoding BTF allows us to specify
>>>> skip_encoding options to avoid having BTF with kinds the kernel itself
>>>> will not understand.
>>>>
>>>> The aim is to minimize pain for older stable kernels when new BTF
>>>> kinds are introduced.  Kind encoding [1] can solve the parsing problem
>>>> with BTF, but this approach is intended to ensure generated BTF is
>>>> usable when newer pahole runs on older kernels.
>>>>
>>>> This approach requires BTF kinds to be defined via an enumerated type,
>>>> which happened for 5.16 and later.  Older kernels than this used #defines
>>>> so the approach will only work for 5.16 stable kernels and later currently.
>>>>
>>>> With this change in hand, adding new BTF kinds becomes a bit simpler,
>>>> at least for the user of pahole.  All that needs to be done is to add
>>>> internal "skip_new_kind" booleans to struct conf_load and set them
>>>> in dwarves__set_btf_kind_max() if the detected maximum kind is less
>>>> than the kind in question - in other words, if the kernel does not know
>>>> about that kind.  In that case, we will not use it in encoding.
>>>>
>>>> The approach was tested on Linux 5.16 as released, i.e. prior to the
>>>> backports adding --skip_encoding logic, and the BTF generated did not
>>>> contain kinds > BTF_KIND_MAX for the kernel (corresponding to
>>>> BTF_KIND_DECL_TAG in that case).
>>>>
>>>> Changes since RFC [2]:
>>>>  - added --skip_autodetect_btf_kind_max to disable kind autodetection
>>>>    (Jiri, patch 2)
>>>>
>>>> [1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/
>>>> [2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire@oracle.com/
>>>>
>>>> Alan Maguire (3):
>>>>   dwarves: auto-detect maximum kind supported by vmlinux
>>>>   pahole: add --skip_autodetect_btf_kind_max to disable kind autodetect
>>>>   btf_encoder: learn BTF_KIND_MAX value from base BTF when generating
>>>>     split BTF
>>>>
>>>>  btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
>>>>  btf_encoder.h      |  2 ++
>>>>  dwarf_loader.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  dwarves.h          |  3 +++
>>>>  man-pages/pahole.1 |  4 ++++
>>>>  pahole.c           | 10 +++++++++
>>>>  6 files changed, 108 insertions(+)
>>>>
>>>> --
>>>> 2.39.3
>>>>
>>>

