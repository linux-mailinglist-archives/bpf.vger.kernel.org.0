Return-Path: <bpf+bounces-9506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA617988D4
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D6D1C20EB1
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06F134BD;
	Fri,  8 Sep 2023 14:31:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7414292
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:31:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8BF2130
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 07:31:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388EAQhq001194;
	Fri, 8 Sep 2023 14:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ud8so/xwgghCo9lY+HAqQcou2JZ9VUwt82Nz2LbRmEo=;
 b=oNQl9+YovB8qNNKhrcfqAURZnivJsym+AqQN6Bnrmt7keGbgORgnBd6IcNCjg414QrjD
 qWj26zcXFERBOEyvPfEWWTkx3atFJqG4QYmxyHxUuAp3wA36QEJe+RHA4JcazwS4b+G+
 DmuJGSJ0LRBdK0caKKt66kjHbPS2c62Qt7tpVZ1PjeEgO6Mc7V1E23SnrufieVzg6r4m
 7Mt252dCyXiQw/4okLj5Eokv32AAuFoNUJQ1p4vc9yPnqxndyTiuFWMWpv5rdR7Ppsi3
 sZw5lcg7YFvkyoYvnKat+qrWaYXfAYmsCG4FOcNjvVSUZMlHz7zyZ66QpuM0la0dbJRM rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t054h81s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 14:31:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388ET1vG039849;
	Fri, 8 Sep 2023 14:31:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug97gkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 14:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtFd8wcNSGag0fn83SqAnGKzVU63C0G6T8IVQowqoPE8wqfEBtKpZVfJIknsyDwhOKuPUC8O6l1rhx24PXbFQ94qqDIKOQs4mbGgycaaolhjrwc1PxwrrGmmJEYo+Aukqj3rzuti54z+A9LFWb05I+jvXd6q8OacNbZB9DK6AO2PLTAzk4A8mOaLeMpRTNS6osmifzp80ju3gCk9OvO2C+A9teM3/Q3zb3v3GmBc5t5vmslopGpFymaYP+btDgxWripQzmLL90pWXvpVBhS4wWu9dwiMDtMJz58zILRfhp/hg7u22x8pgurVDZ9VnSlu+5HGaeLyd+G8NbVqHRlfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud8so/xwgghCo9lY+HAqQcou2JZ9VUwt82Nz2LbRmEo=;
 b=iMt33932wmHToUq/W41ORI6UY4nbcboHPta24uMHILLMWkxseVflp6n2JRM0HWTYsEaurZSQxOe9VCei+n+Px6PWO/DlorWKYQMJ0kPgFYXuw3CZrsXWXrF/XehMvx2z/HuodfG/tIWp5nor5Jgjzh8rIGPtmC8Hgmz5cNJwSwa/KmbZo+T08aUXLxvr3pSEDHP3lAUXK6cgmcN+2l+On9fR2mMnqoNcZRzzSyfy9ScYcIDrlPVyIMuzMWAeQNkBuK+HH7ZQHZ+DN37tjovvKAaMb1VvDXX3brTzF1tn3wARr1OjjBXi7HqstmdRBZ+Soy5//GtHH6IMI3mTMh3AkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud8so/xwgghCo9lY+HAqQcou2JZ9VUwt82Nz2LbRmEo=;
 b=jjg5A8dfqKK/Qde5ffFkiCfKsqbx7MfY/nPiluW0BDzRDA49o2MPLWLl2n5fyXuCv4sjxHj6VHvq9edkQWumnyiI8lBaFYGotZupjE2LRj3yGtdEXdpFfNIFWIakxBOjgHn06KToi+58p3yARqdCMlPC0A5vPlnyAQ20g3k8A58=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 14:31:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 14:31:00 +0000
Message-ID: <7c7f9cb8-2dfe-b4a3-92b6-9f69dff07218@oracle.com>
Date: Fri, 8 Sep 2023 15:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Resolve symbol conflicts at the
 same offset for uprobe
Content-Language: en-GB
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        olsajiri@gmail.com
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-2-hengqi.chen@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230905151257.729192-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f39b11-7b0b-420f-aa7d-08dbb0783939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OxK6pys75wGURAISdasP8gb1ND0vG9yNS6tQdUGlfamd8aXcPLUJ0Vrr1CTzoz4L5f+XepGJZbskyvt1XqYz0FRGKbbI3qN3fnQmy/1ZNSUAeMqLDt8SP2aPMsunmXarJlTOB3aRD93DTxlxc1wH3MnAbFGbMDvi1bPkqM6rToMEdyQbkbzKIM18YxeoVOUurIpB4iDgiEpQ7/RbCuZ0nj1LM1OrFmmlzvKbgEuCCQZOaiVrSUXLjqFeDgROC9s43dZczE1mEwrpgTJYUnjDWyYMqydyVjuiJY1yxY/2osffrNONGrIpuvjYqGNX7rz2ogdcUstRrSKD4tJWcsK/IhUNjaJFvy0MEi5U1nghjzb5CjqGPaZgCl+F3Zn+EGNJ4ZsCvCaDftIV4AAgOTWM3iTDmdF/zeSHsPqPBFGpxRAe1I8w0dgtynmJ6XkIBp8kNexm5d8t+IWnHZwtqvYlmM+sefOQqGbJWkfJ7jv2FhGW6bxkDs3IZZaLcvKJBuTVxNtm/2QEROSDJ3Uf5Jh4Xwfro9++ppwqU0d/09802P8EgnVnbE8bClbFPMpu6lPDKyC9EBELYFRv+xzKc/nE7QMCn5bNbTJ/Zhwf9oScyyGd6PODIizF5UGceIeiuJMqplUzU/LdhN88ofZBneL2fA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(2906002)(86362001)(31696002)(53546011)(2616005)(36756003)(6486002)(6666004)(478600001)(6506007)(6512007)(38100700002)(83380400001)(4326008)(41300700001)(8936002)(8676002)(44832011)(66476007)(66946007)(66556008)(316002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmVyTFR5Mm5YNjdUakdKM3pxOW0yVWM0VERiRG5RbVVLMy91YWUwdHV2anVm?=
 =?utf-8?B?QjBiRjN4bExvalNPL3l1di91K0k0Nkpwb01SaEhDajI3RHBlc1ZoOEl4T2xi?=
 =?utf-8?B?aGIrckdEUUxuc0Q3UTJ6elBuWTAvRnY3a1A5NnRTSU9QWHhMZ1MyemZyS2Iz?=
 =?utf-8?B?VmRqRWs1d1pDdXpZeGxVZytwTktlWGZZcVRxQ29CM3hkTEU5WnY0UXc5S3k4?=
 =?utf-8?B?S3hEN0RDUTNsRVJXLzFFa2w2dkE2V0RyK2x4WlFwQmo1aUpxR1FQRWVrOHJm?=
 =?utf-8?B?R2ZScGRubVVSUGxoLzhzc0FBeWc5YU13VjExc2YvbDI2ajVpNEx5Nk9vdmg3?=
 =?utf-8?B?SzZCZEVDaWNiMXZYN3M3d0k5b2dGQ3ZGT3pCNVIxaVpQTlVxcjQwRjZ2dGF2?=
 =?utf-8?B?UGdKYkZ0QVVDSFc3WTU4KzdZRnRZczk0a3FSOVJTUEhRdURKWTNUQ09NK3ly?=
 =?utf-8?B?VUptUTZxcnZKTlkvTlNsOW5NWXk2ZmtGM1poUEwxUUdkcHZjK212Zmg0MzRU?=
 =?utf-8?B?cXRZZ1l4b3MvUWFTTENQbG8xb2tHUm9hTW04bHArWHg1MksxNXUwWFYrTVZI?=
 =?utf-8?B?N2lqTW1XS0dYS0V4UkIvZEJScFpvbEErL3VSRVdnU3M5UTVsYXU3SXFPYll5?=
 =?utf-8?B?RnYzSmc4aUFCQzhrNXVleXcyWCtjaExqeHhscWI0Vi9BU3d4akRZMU5wOFNS?=
 =?utf-8?B?dzJ5bXhZT2FpdjR2bmRpc0ZtQXdGb0EzSTBrSTFMd0VQWEtkRTU0K1hlUStt?=
 =?utf-8?B?TjVyem9jajFOT3BzY0ZwTmpFMi9KVjhncUhtUTlpcERCS3JBeFVlcUczV20x?=
 =?utf-8?B?YmNod1RDMEt0TWxwYnRMZGkyNFl5OGJmbkQ4SlQ5TDRmRnJWTG1SSGNRa0FM?=
 =?utf-8?B?MVZ4MGVYTTBxQ2RVYU9LTTVvekRrdU56MG0zc2NHYmdoSVB0ZU42dngrQU5w?=
 =?utf-8?B?OG9qakRiOFcwL3QzeDQ1MGFTbndaWTVycHA3T3dkeU9jL3UwTXNSc0N2SklS?=
 =?utf-8?B?azFNSkhzdHV0YkllMGRTRC9rVTVWSFdoY3RPaURiUm9UTXdScTJjRWdTYVJp?=
 =?utf-8?B?dnFoQjd5bW1UZUpucHNwZEdnZGc4dUtOTkNxK2NiY2dDbW9XOEErQWY2d1Jt?=
 =?utf-8?B?NEI4cDlkcjlBZmRmWERvOUx4QUxBelVXNGhLZGZzMDVlRmRjN3cvclIxRllD?=
 =?utf-8?B?TmxFZTVFejFHeklTdTFiVTRjazRZbnlQeTNkalRMazAyMlpZWnRoQjg5R3JU?=
 =?utf-8?B?R0hPWnRrUG52UkFBb29vWDRkcldtRkxzS010Z3BROG81Z2J6UG9ld2F3bDA0?=
 =?utf-8?B?VUhkK3RpZHdNYmY2VGMwSm5mOE1pdTVrU25pSTQzdDhMUDRyVVByRTlxQWpO?=
 =?utf-8?B?WUdQNE9jVEwrQnV0L0RhMXVWNkpyWXNrS3ZRekYzMDNGeUlIaWtrM2pLMnk0?=
 =?utf-8?B?RUJybjgwYy9Qa2ZKQUZxVUl5V0ZtaWhzVEQ4dHdRWWFXMXBIOWZDSmFRVUtY?=
 =?utf-8?B?N3lRYndmM05HUytYaVFmUENaVFMwOVpnV0l0WHh3TEVGSVp1N1I5N1FFK1Y0?=
 =?utf-8?B?QzBneU9nSFZ5QXlaY0lxQUtaN2ZGVXpoQUM0RGJaTmhiUHJLZHJ5MWl2ckZN?=
 =?utf-8?B?M2hCWitVcnVJb0RaQzMrVU9UZ0t0dnc0eHR6NTdXZVgrWEZYekdOOC92UVA5?=
 =?utf-8?B?dDJiTStOMmVKeHBLWXh1eXJ5OHpGanVVZHU1bmE2OU01R3VSdnhlenVEek12?=
 =?utf-8?B?K0NRNWJyUElGaGRsZkRaTkFTaUdQZUFZa2FySGhoUlUvcTljSWdubUtyOE5S?=
 =?utf-8?B?Y0FwRUsxOHB4dHlFdXh0NkNVazJmUEh1VWphNmZpMUF2YjdORXh2SlFmUW9h?=
 =?utf-8?B?SXBNbHRWd1hmckQwV2pwMDVic3BiU2ZJelo1TllzdjZUM1NOS2dMc2UrVzFR?=
 =?utf-8?B?WFhPUW5uWDNFWUxNbks5OXBwTzVLYUF1VnYxb2hwY3VmRUNHd2IrdjRDTHZX?=
 =?utf-8?B?c1VxT3BadVJiSUpWeTRlZWprdmcyYnl5d29JdzBOSnpyZGZ5SkxHSHhxQmVq?=
 =?utf-8?B?Tk4zVDUvVC9nQ1QreEprQWJCZWFuYWhlTSsxeDREcEVLVEN3S0cvU1Mxc3Ux?=
 =?utf-8?B?TkZIbVRHSldwc2tEYk5VOHZTNG82UUV4UE1nMlI5YnJQTzlIRjE4UlVQTnZK?=
 =?utf-8?Q?6L+xdtQiV7bCigpNP7OqWIo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i1r092yYqyLT3QpGMOA1zDcakCIzBXrZ/O6o7G0TLiGJFmvwE7Iuc3Y9oz/Qot52t6r700Fq3Zt6n9KFpQjmnTkJd8cHF19ZOKWDPSxa4P5m715bH4b5YYrLDf18cJuCf/gJ0iSMY8RTy0eEWtoo5G2tClEd8EtSTqTWvnF5MkXdnPoToEVT8IhncOXuPE1QK4RWb1rd4LdEsXuymvKIx6JbAMDs+CH9vlkqMlzFriu380+h1ODG69xCP/bWpKKlu8lr9EIqgei8HWdhJglUiXFnnzqSiU7g+b1d/STI1E6o4w0afeS6yUGCXd6ZXX/xRxXugcw9++YftT7qXk1iZfc5W5gZBhE0kRjo0MAqQXhukncn7i9EZMGNUEZxug/4/QQHzjqsbxPAUDG6hvdJAzehnUjumtFogr4WhIxe4A3qIuMWrgKVTC3nySb9q2Fj5oJPc5K8zr1mo7poI5gDMOxDTPwvivLB5BVq/4pS64bDVHU/r91fFksggxPNwPExPK8UbFDrrlpE4A8bk/TB30UtmC+jlWlVCErBwfweJ+s3QwrAw/9FwOdw61m9wkifIrbA31HFFLgQBrviie1bJHiHFTlY2mMPUu4ySTTD6hxaK/KsrE2xzIfz64Ybsqn5GmxGoBE8+o7jflTxBaOj+uf6nZmt3AO+UB46ilL2EgvEDf3ipCofCmVGnuZg2oOSATheHZZNsR8OeHZ1Qg0+sz0G8nV0WsdeOp7w92kXRbFnJcPApr2exZFbA1FGQN8Bc1D08rBF8lmn+/5J4un5tjpyEBYbTKOwcB1HFWep5L7B5rRNdj4moXgAiyghz+UgbPnqeEFgrgMVmJhx/RJXZkImWrW26BMp6eLHDYoQWAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f39b11-7b0b-420f-aa7d-08dbb0783939
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 14:31:00.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRpgl8Ag+S+EyniWbZ6wC9x0ynYhcdzpkmOI4p+84nXv6YdHZjwmq743js9n6lUT3Q1fYhWHHWSlVKR+vd5KDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080134
X-Proofpoint-GUID: QizTOtthuNDlxVYC29GqSXbLof9qgS3V
X-Proofpoint-ORIG-GUID: QizTOtthuNDlxVYC29GqSXbLof9qgS3V
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/09/2023 16:12, Hengqi Chen wrote:
> Dynamic symbols in shared library may have the same name, for example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>      706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>     2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>     2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> Currently, users can't attach a uprobe to pthread_rwlock_wrlock because
> there are two symbols named pthread_rwlock_wrlock and both are global
> bind. And libbpf considers it as a conflict.
> 
> Since both of them are at the same offset we could accept one of them
> harmlessly. Note that we already does this in elf_resolve_syms_offsets.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 9d0296c1726a..5c9e588b17da 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -214,7 +214,10 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
> 
>  			if (ret > 0) {
>  				/* handle multiple matches */
> -				if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
> +				if (elf_sym_offset(sym) == ret) {
> +					/* same offset, no problem */
> +					continue;
> +				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
>  					/* Only accept one non-weak bind. */
>  					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
>  						sym->name, name, binary_path);
> --
> 2.34.1

