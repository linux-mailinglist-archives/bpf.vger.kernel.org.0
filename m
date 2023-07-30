Return-Path: <bpf+bounces-6389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D096A76881A
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFD281641
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046AD14F90;
	Sun, 30 Jul 2023 21:06:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BE14F6E
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 21:06:44 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475410F9
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 14:06:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UFumqf030392;
	Sun, 30 Jul 2023 21:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jY2Nzbn/HO64gxGt2jTYIHBVb48c+AMRrkWShQLItpQ=;
 b=awSKz+i+P3esxh+nnzsuwlxVhja7f5tWTY2oyTU0/rt4gZI92YXGZVkK9f2sDSlR2Ry1
 BAJR7HJxp4O9P9vb+t2vDkfCOME/lPm2j2ya6kfgaXYIgnoNqU4LEP9TFncagL0i8CsE
 1JF9sOSyVW0sB7AjRCByJoH5W9Pv6UrAPUzT4t38a71FN1c7kq/YF2w1QxUEH7pCumaj
 QIE8/AnPzcKUbnrZqgkZTZSxxBfQz1QCJmwGJPFtb2FiULuD8jGKf/CcD1kT47Sqs37H
 qGQW8iubiOgeYroyPF4bE9mXXy6E6ciwy/6cRasdNlqCB7Kvell97V7TcD0FyeaqoM2D mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e1eqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 21:06:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UG3FKP033433;
	Sun, 30 Jul 2023 21:06:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s73t61c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jul 2023 21:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLwBjAmFpGfde2ZU8j5T760Upfzy6JzFdC4kXOa3DxZokFHAF1mFL/ykl84CxUWDbVFTHU6R0hvBhCWUz4hMWtlyZWQ7LeuQqmKq4+yzxbkRBbJLzN1samJaNpZrVYvU4V7wyWdQi3ueZggrtd/BDU1Obler4pjPHRIoqRJE25TXDiYa2KHfBI+wD0lXqj/YwhlC8UHUzk27Wns+L4i7M8WgwmXWiz6BFkJaU31Aj/vScVtRVlRL4+IsCm+6THbmlKwoBBAyI5zIGY0HfWMuPuJwBqcmAUVFZ5py1Zx+Rss7Fiq3DZOZb+IdFzCn7EGoqtmi9ibHef4+PvPraTpJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY2Nzbn/HO64gxGt2jTYIHBVb48c+AMRrkWShQLItpQ=;
 b=KVEQvMABayRr6nH/vp5byxiXy1CoNrLBQ/GtXXsPHq+8y7z9M5zM8y+dNCImoCT2zAA7akv77ARVhxeR73dCD8dPozVvAZq29MA6SHrhxPPmGYJuaX7BxwkACH6ZnayBGb5bPSJJf7pNPvQpSXh+r9Zj5/Z9IZuRPi46owlArAVNvWpL9rNzuTM+ygqk8yT/zguxfrR7cglX095oSMuaRlOuyK9CBi3A26uOYwyuy7jVKpPC8tgqojAb1YpLnNDqLNgwSP+FEJYZfE7IggxAy406bAFg61OLnfFWxQd7SwdeWSbbQDpqQGOrtuBULoML+4qhE+slxZ6RbS0v7yMgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY2Nzbn/HO64gxGt2jTYIHBVb48c+AMRrkWShQLItpQ=;
 b=P8OSLdWrgOY5PEXS36wAzTCKCtfuJobX8VHihsJCKVFwFXtIgmmDCQcWKbNQ3TAqnD/2z+mCq+3CfTPSuA1tEk9NTe2b34GbK1LlHFT+cM/8G57ww8xvWSJoNl0usld/1J4PDmLTzPaJkraRCc/t8a6jT1ETRjenmKhYl0o81Rk=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 21:06:35 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::c495:8d34:80c7:d66f]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::c495:8d34:80c7:d66f%6]) with mapi id 15.20.6631.026; Sun, 30 Jul 2023
 21:06:34 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <CAADnVQ+gLXpeY-kOJ_cEAuoXkrQeeD+KL6jsFfyDXcm+rk-xmg@mail.gmail.com>
	(Alexei Starovoitov's message of "Sun, 30 Jul 2023 09:53:51 -0700")
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
	<87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com>
	<CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
	<87jzujnms6.fsf@oracle.com>
	<CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
	<87edkqm257.fsf@oracle.com>
	<CAADnVQ+gLXpeY-kOJ_cEAuoXkrQeeD+KL6jsFfyDXcm+rk-xmg@mail.gmail.com>
Date: Sun, 30 Jul 2023 23:06:30 +0200
Message-ID: <87edkpkt2h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2890:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: da78d5d9-0f7e-4be0-a837-08db9140db5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ppa00tmXB0JnyyheGEX4WnzeFQo3xzhqUQcB9sk11Z+Qga9GwT1g/IGtQ7qNUwcccNLnCbkNKnvhBfrau29URGUQ2Zd9TxZc8crnffY7xLPbzqY3H/4QNDOTh+7vDbTLgaYOOcw9ZAW07yowYqgvEJRqa64a8XatLIfFku1KZyspMOOnn7d23fAdHQsM0IDAiFp5s23eJV7Z4EMVGTWf+XjjNAQ8RsKaYjX8828cj5XFuJ82ws1APPbjESVocpDh+jKzdzbVMHyX6ITcuoINB5040y54xVNaPpBK4rANZCe3e9QJfQksJelYjG4dnsjhOFocTmXelg+YPcvJZRxRF1/1GxBRmLt9oyh/pwsrxEELEz62w1Eh27KHFZf9DMSvEOrVt8Cm0e2n8OXfsMEoC0kZEFhnhWiBNBtrAVo+8/jZMbppljdQMBeWZAbBz5wpzRqknZKwGNUBliMAPL7Hzvo2AxfKuBmVBQvfCaWbI1DBrNdosGlX/xapNecjk4GVbK6I+dSo2GpAFNhD3CzXsNWStchbwgJYFZxDHtdu7bg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(38100700002)(86362001)(36756003)(6512007)(966005)(6666004)(478600001)(6486002)(2616005)(53546011)(186003)(26005)(6506007)(8936002)(8676002)(5660300002)(66946007)(66556008)(66476007)(54906003)(2906002)(41300700001)(6916009)(4326008)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmlkR0xycXNNUEpMN0E2d0hleHNnb2VpcXFpR01HdkVJQ1ByWGFGNW8zZXoz?=
 =?utf-8?B?eEwybWhrWHYvWFhoUVM0WFhIQlUxKzZLdkZMNmd0RGs5K1NvMUcyY2t6YVhI?=
 =?utf-8?B?d0VvSFlneUFmZEo3VC9vYWs1ZEdlQXo1cEZoQ1lLUEh0SC9WaEhuMUtBUHdn?=
 =?utf-8?B?VEI3eVlGZXBkVEZQb3lkVHdNR0tJRWFkRDlvaHIzcXhPZ0xzL0lvL2NTaU0r?=
 =?utf-8?B?TmF4V2pkSzEwb3lNaGNVejgwQVNodENUWThLWWdMdWJrVlNMQ1BFa01LTTFr?=
 =?utf-8?B?TEdBaG5VcUQwRGZGZDJpZGdqb3c0YkFyTmNSdU04eGhPanltODJIbVNJYjhk?=
 =?utf-8?B?dGdxMTg2cnNuaDc2aGl4eDJidkp4ZlhiR0NyTEh5L29DYXp3WC9wdU5FMGJN?=
 =?utf-8?B?eFlrQ1UxQ1hhUEtXMTlwMEV0SDREK0drYW5LcVBHOUZwUEJVeDFjQlo3MlZC?=
 =?utf-8?B?VFB5RzRaT1dEYm1ObVNJdWN5RUlza3JCUXVNSjJRRXJDNlI5WFRoa3l3ck9o?=
 =?utf-8?B?U1dES2o1VUNuUFRjTHNzMU1IdXBTNVk5cFBOSVRoSWNYK1ljeHF4S2RKK0k3?=
 =?utf-8?B?MTRXWVlkaWE4Y3pTTzJFZFMzc1Z0ZzJBODdaOUs3aE9WNEsxL3V1QjZpU2ZM?=
 =?utf-8?B?d0oxRjhkb25pSHhySnJUOUFUNG56S2d1WFFTTWo4R09uTkpCUnIveHNwM0sx?=
 =?utf-8?B?OE9INk11ejdDZ3BkamEwS3JQRi9sUjVEOU5nOEliR3VSaWlQd3lVWFpWbGIv?=
 =?utf-8?B?dEpQY3VyWHlVbk5nYzFGT1NrTWsyQ3dJb1hZMUc5SjdGNlFoc1VCZllZUXNN?=
 =?utf-8?B?eWtKYlo5UmE0VzV6U3BaTGxRZnNXOEtQTWkrSzBGWGlwS25CR2hUZTkyTGJD?=
 =?utf-8?B?UCtmUmdnVDhYMmh5TXppclo4aW40UUZlbFMwMkl4b3ZQeitDUjdaY1JGRUtl?=
 =?utf-8?B?UE1leU5XbC9QVi9OMUtJbmlwR2dwTFQ2UTNiT2d6RGM0N2xRMGROWlpqMjAv?=
 =?utf-8?B?UHZ2S3Q0RFIydUZOSUhqbTRZbFBUenlUOFhKK2lWam5tNEZ2MlBXWG9Pc2VZ?=
 =?utf-8?B?Q2RMWnlFZmk4UEpUUjRvNENCMjRqTDlnUlVkVGRPREVDcjJ2Skg5TGJlZkc2?=
 =?utf-8?B?aTFFZ0o5VkdwSUpjcExaaW5aYmRJYVdZSXRrNmRuNnlVcVVodkcraGw4NzMy?=
 =?utf-8?B?L096cGgyc1N2UkN5Mmx6c3R6dEJPV01EYjF3Um5uK2UrN1hGTUNPUW9yQ1Bk?=
 =?utf-8?B?MXlxaFUwMHdCL1ZQS2JnNHRpeXRLYlB6aUsyYzB6emRmaUZjd1VzRlJITjF0?=
 =?utf-8?B?VFBJNi9BRlBqVGlaWkdIRDR2UC9rTVVkeFcvK0lzRjdjdHdLVVpxN0pkdERz?=
 =?utf-8?B?cUROTUsvSGVDdnQ3NlRKd2Q3aGsxWkxJMkRML2ptdmJMTENMam5XbVV0aDlt?=
 =?utf-8?B?L0pmZzltZjdhM3J4eFRrb2xvQ2x6NXpqRHh0OUM1V21hdXp0RGZmNmQzN1lP?=
 =?utf-8?B?bklkcTRyS0E0cHp4a3FicE95SzBFRmErZmZuaGNCWmhFeWhmS1dTWk9Na21j?=
 =?utf-8?B?aDdwRnlVL3hJczlKMkhEVFpnWlBaaklMcEFnVElNMWJ6Z04vSzJ1UTkvOWZO?=
 =?utf-8?B?U2I0UHdZZVVzcmxYaitjQXZpZjY2cHBpUTdTZTBHdjJjcUNrN2JxOVNKb1lL?=
 =?utf-8?B?TEdIUFJncUJUcGVteTNDRi8yNUtrN1VMK3V5eWtKS0lqci9DNWd6ZG10N2FX?=
 =?utf-8?B?YUhDeFFzTDZ3RTdVZU1COWpYY1pzWEttS21Ic3FPOHUrbGV3YmNjQjdNUUdH?=
 =?utf-8?B?OG10bVMvS2RaYzRsOHlKQ1VPU2pDQjh1WEM0aExrZy9VZlY1bUNVWUtTSi9s?=
 =?utf-8?B?ZWZQSkZkOTJmbEhUN3NIOWhlREx1empoa1BzWGpxTmVLbHNFeE1UUWx3U0Vn?=
 =?utf-8?B?NFdIL3M3T3pRUy8yNlcxK1EzUnFwUzk2c0hvdDF1Q0xJRk53RVhOU1hMeFJ5?=
 =?utf-8?B?a013NFRicUFFUGVBeE5IWFo3ZWZNQ1NMR1pGMnp3anA1amZoY3JnTW9iWDR2?=
 =?utf-8?B?S3l4SVM2RU1WOWx6QWNtNkh6RzUzUitpVHhqbDJQMHAxbHE0eVZ4OU15aXBO?=
 =?utf-8?B?eU56Qko1RFhrQkFEMUxxWkdiTk1sYzRxSzQvek1JbVZ2SmlXTXgwN3pDbXNq?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v5e7O2CykZYwgt1/45rUtatAgfLRjs5H3o6z52mE7IMUls9apeJfaGSp15jAWyR5Fip3ihmvGK45WU4jkSmqh9w/GB3JyC1dXCGkVn640qAM9JLScgjZeCJBXn5OhCmlL3X9KDU5Ufyd3qgiGNrbeJ+5odQsHkGUPNWcMGp1grrpmX4T/jq0MUFinNgCvwS0OWio0v0vUv+0SavkcDTneO8Q2NY2BRyD7o8VhQAT6V86juSApiznTacOlHvg4DqRKXqSC0QLXUpcjA8HxaSP5MueSsONlzZ7IqhOAI8v4dJ7fQ+XUeNSQwD3MvalVOz4JKmKSBRabdIbGs3WnIWemZYsVbVtHU8eKKQduRzmdizaanRNANSKtyDDmBbzQiIqK8jtAYl+oGcfOqpnqS57pwT4/LdeKw4786BMSIG4eFQ7b30GhdkhGKdjbwL7TO/g41hbFt31kbqB1N0tNb4ySCV431BwaNaGN7jK7blS+p/AsCc1l5I9/7aXutAQB3cHD4anKtapGXhOQWSlk7gNo8IFAc1ms0ylsnqqpfOQpn8hlPqr7bRlvdsJKJ3ZkJn8SPOnPR9rYquytnuUlKkUtvfq5qiscRWKLZ/QLIIxU+Z1g5zvL2fBOwQr3sebSC091II+RL+ENKuigZT8Ng4p+EM5+4kI1WvkiLO8gbxTZrHp1VOQJcGumY5QjPi/TizRtceLg/ohf/SbFV1lftI9JZnP7kkbX8K/+mMjv4QSIlE9ntWTLZnHsY7uk5abTcyMyqn1XN+YwTaYsfHxGnPCmndLc2KFQb6l1CsHjfL5eiISpfrwNaYlCjUQIJVsWMqT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da78d5d9-0f7e-4be0-a837-08db9140db5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 21:06:34.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dgIocrI47pI+bEjrxUHkxOV2Y8vDE8+Jqy2m2tpFt2j43etwZNdJ+Ng0OtkL7vsnLcXsoS36JvbeKT69r9V/hy0yYCLNBZl1fPDfmXLYVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307300197
X-Proofpoint-GUID: bfApFeakGZDoKRgHiAMVvWE_0UiW8U20
X-Proofpoint-ORIG-GUID: bfApFeakGZDoKRgHiAMVvWE_0UiW8U20
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Sat, Jul 29, 2023 at 9:54=E2=80=AFPM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> The individual flags... I am not sure, other arches have them, but maybe
>> having them in BPF doesn't make much sense and it is not worth the extra
>> complication and wasted bits in e_flags.  How realistic is to expect
>> that some kernel may support a particular version of the BPF ISA, and
>> also have support for some particular instruction from a later ISA as
>> the result of a backport or something?  Not for me to judge... I was
>> already bitten by my utter ignorance on kernel business when I added
>> that silly useless -mkernel=3DVERSION option to GCC 8-)
>>
>> What I am pretty sure is that we will need something like EF_BPF_CPUVER
>> if we are ever gonna support relaxation in any linker external to
>> libbpf, and also to detect (and error/warn) when several objects with
>> different BPF versions are linked together.
>
> Ok. Let's start with EF_BPF_CPUVER 0xF
> and not waste bits on individual instructions, as you said.
> When kernel backports are done the patches are sent together.
> It wouldn't be wise to backport SDIV without JMP32, for example.
> git history will get screwed up and further backports will be a pain.
> The risk of untested combinations increases, etc.
> I think it's safe to assume that a given kernel will support either v3
> or v4.

This is good to know.  Thanks for explaining.

> The kernel version doesn't matter, of course :)

Yeah GCC no longer supports -mkernel :P

Allright, so I just pushed a binutils patch for elf.h, the disassembler,
the assembler and readelf:

  https://sourceware.org/pipermail/binutils/2023-July/128723.html

Note that the ISA version selection logic in the disassembler is:

1. If the user specifies an explicit version (v1, v2, v3, v4) then use
   it.

2. Otherwise, use the EF_BPF_CPUVER bits in the ELF header to derive the
   version to use:

   2.1. If the CPUVER is zero, then use the latest supported version
        (currently v4).  This is for backwards compability.

   2.2. Else, if CPUVER is one of the supported versions by the
        disassembler (currently 1, 2, 3 or 4) then use it.

   2.3. Else, emit an error "unknown BPF CPU version %d".

Maybe 2.3 should be a warning instead of an error...

