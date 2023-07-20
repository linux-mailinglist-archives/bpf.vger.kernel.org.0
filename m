Return-Path: <bpf+bounces-5419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CFB75A686
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E16E281CB7
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B613FE0;
	Thu, 20 Jul 2023 06:32:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC93D70
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 06:32:50 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E992123
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 23:32:17 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 40F91C151990
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689834685; bh=wgF8mqrRe2ymj0o16xjJR1WXwZd+LCSGwUBsYGZK5os=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xlqe/Ksv+8M0+Yx+uSCYtCtCcJuvpP5YYH5836ByXFobue/Y1FdmZIMje3plTi2Pb
	 Rccw5oD7yejpENB+ws62IaDwTqGjY2tdN/0NvvjCeo4McJRvDEKkhwpMFXhnIpLGBE
	 TTUBOHz8tpBozfQLcAU45OnjPKsKENBiZQbMF0uA=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 15766C15170B;
 Wed, 19 Jul 2023 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1689834685; bh=wgF8mqrRe2ymj0o16xjJR1WXwZd+LCSGwUBsYGZK5os=;
 h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=jX1zd3oKVC6cmXBp8f7YKb0lCVp+Pi/5KowYvZiaEhR1TTfhDN4bumZn2ZTGHfGfN
 RjDWmvF+o5ZGlQSoeQwp1in8C9AJODdMRq4AXGwuujEgvYchprmCYs9Fl5hLRsyx36
 8KO4KTWHjUDQqxY90r7PaYDrdq1fcrOkTA+6jUqQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F2CDDC15170B
 for <bpf@ietfa.amsl.com>; Wed, 19 Jul 2023 23:31:23 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.095
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=meta.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lyrXqRII6sEi for <bpf@ietfa.amsl.com>;
 Wed, 19 Jul 2023 23:31:20 -0700 (PDT)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 32434C14CEED
 for <bpf@ietf.org>; Wed, 19 Jul 2023 23:31:20 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36K6QZAR006583; Wed, 19 Jul 2023 23:31:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qLqz4vPNSlNi6D5osFVV3EkOOqq/ayrPejWpo9IFkKA=;
 b=n13SCZrS4z2jASTFHEjc/OcyGXv5qm2WKHDaldceGTPuDAyRlRUjyWPGklZraIm8mkyR
 TWcu8xVKXrn4bEvLdihQCTMoiPZG4m7barjBSs2N4VW5JD0e4yl/FcqkYBnWEBIXyhJr
 f+56AvF7ITRbSEAMxIG23DEP5giNKP68FcuSUJ1MPge3mS/4nw3wNDv9ySFSHpCHTfBB
 r0JhcnSaH6G0bFNuKEJ2DgMWgAXdsx5hH6ikFeCkmA3b5XRruX98XdgqgS3MOobz0N8h
 akXres9Dpz2TAKEFMpZY7n93JOXCXcee7Xn/8B100zqlL8T7oP7+QnWJyHXwW4FD8G5O mw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6s5bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 23:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLUG6qVzuYLGc1Ys9id5GtkOJUkJBjnTOba72b4O3d44pBpwioraNht5HWzNbXgP71RRahIeln6o7fhWll/CiIMFEAT11eXXb8ULglp3Tq77LezshYG18/98dkn0DLiFCJK5pqWDsWAPcsGAicWTx2kiC/fNPBocoE8SzSr8Eh6H5NBTlMwTkqKE3VZVgidlI7dUDJZpb1MP5imff/H2rRPeQCaSepOPk3xZIW7aThu0QfuH1ze3PlWGDW7sdnvUhEoyp5gAONwx19gtB0jBeWFXYy5ZxJ6GOD4LesTfV3gUZBho7hsREe0k59xZirNfADTMb29P1t6dWYs9Eh3dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLqz4vPNSlNi6D5osFVV3EkOOqq/ayrPejWpo9IFkKA=;
 b=afCdZYZvoT/VQOr0aYdjcTGqoah1PoHIwVEe/DpESLkT4uy6OGeXIp5YfA1tUOPzdOA6HFKqjKbjvyMnu0w6OwueY1OtjstcBheOk4ECBq3nip8ZisMlV1sm5sICfS/sK4QYEpe1Gh1y4XlpxbkNzfKK6mEVFOwN/fxJqmTkMfFJ7pxl9YRTfOiNcB6RlTmqEwXFJINe0NDcfAiJsN5yHi7HJXXIIhXY9QQxI4Fs/LlIlUTPiSMos46UnrVmY9Kx1rrhP+CC/qqKPLBnewr49i9vUYd9v4IcPAy1D5tujTFze6EOROLhX0zJlqHOKx9ONlU2kTfUI4uCSNjSVoVdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4870.namprd15.prod.outlook.com (2603:10b6:806:1d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 06:31:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 06:31:15 +0000
Message-ID: <6be0dc44-c781-a3e9-e2b5-f26e3ffa42e8@meta.com>
Date: Wed, 19 Jul 2023 23:31:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000202.109554-1-yhs@fb.com>
In-Reply-To: <20230720000202.109554-1-yhs@fb.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 55dee4d3-bc86-4659-9021-08db88eaeb43
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvRwt5IhkRGJZy6JXF1T/SImr5NvvaO5H9hQ93/VaJ1fEy52xzuh77VMe72+z+W3ETsWJcjm+XwaDMS1EevnEzYCNihA0tyYa3A3Lw17ZShZDSb2qyh+CAtgrMV+dtGh7vLxdohDsqjv/prUuHCIJl5ybGhDHddJdrfIHoTs9CXDQowI6k7uwWY9Cc9SWRQTa7+afdjJck1LYoNBWbkdmKxEFOVesVna3o9OKFWa6OxsT5ckBYcz0HbMlVNPadpXXuJKW5swrHDDYkOpK7Wbc6S3tmaKh+Qbbd10LWZHQUrTuEPcWllclX2Qjc1ZXmhmJy0Mv0IKAdKwGnwX3RPQ1tAIvVhA4UhA/t14f2wbdfIIXYVl94HcIHUwUnkZney4fHguWEIgH/k23O/Gs5C3QKSoosB+TK6HPTYkc/2b5N6IJqHLkMjKdBL80AOYGdM+xtolWZvbsQhd1W3Yxte8N1843AU5rtfsKYiYx9sgrcFFFwj8crJLw5bLLySdCKu9IDygS4951w8cOl2HsnI+oOtfBr5msCs/wKOqr0quX88jDTvMzvp6Nin15vKQtCt0a3tzvY19FdoxFshX56fMT9CaOh7yuiokUucSejHrE5pZl8QLwsxBuxgc9ICTBIDL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:SN6PR1501MB2064.namprd15.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(5660300002)(316002)(2906002)(478600001)(31686004)(54906003)(66556008)(66946007)(66476007)(4326008)(8936002)(8676002)(6666004)(41300700001)(6486002)(966005)(6512007)(53546011)(6506007)(186003)(2616005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFEzSUNuUWZtc0Z1NnJiWHZoRk1ZdXMrR1hKQStYbE41Vk5RS3lsc0IrYVFv?=
 =?utf-8?B?Q09FeFBCY3pRbytiSlJ0ZUtqSC92TUI4ZXIvemV1UnhvNUpMaHoycENlem5H?=
 =?utf-8?B?cjhwZEdKc011eHNkNFkwUTY4cFExTGErVDZLamUrYjZQWEVhRlYvaGxaK1FF?=
 =?utf-8?B?SDFMbDk2OVQxRXNad1NWcXl6aG5WQTcyUHlQK3hVckRvRkNIYmVLODNQS0l2?=
 =?utf-8?B?VGh2VzhUZERra1JpRThJY0JnNVVpNS93dlRkNGNvMzUvZFpzVDJLTzJRazlV?=
 =?utf-8?B?cVgzWHJYSzlhVlJPcGFkTHJ1QkczYk9CazZBQ0V6T3BTdXpYQnV2WGpra3JZ?=
 =?utf-8?B?emtnRUxvcmxhb1dnNWs0UmZQL2xxRjZZVlhVRmVvUzBGWERyc3R0RUZkRndz?=
 =?utf-8?B?MVNWcWRBVVlwci9hMC93ZnR0SUlZc0lyN3RrL3pYdkVVNnFIcHZxTFlGZ24r?=
 =?utf-8?B?SDVMS01TWFhvbzRIVjYvSzRKdFcvazlaS3h5bG5UQktSUjRheTVPUkw0NSs0?=
 =?utf-8?B?Z2hudlpYcnNHbE1YOHViTVZsRlZsbFpUZzQ5ZFh1anNaNDZBTnBqM0NRY0ZP?=
 =?utf-8?B?cUdNRDFlQlRQTjVZaDFkNE9hVEJPeStib3hjc1J4bTdqOHJYR3JibW5iLzF0?=
 =?utf-8?B?TDBWU3ZCNGhTZ2JqUVVWSXdKckFabjEyN0wrMUpJMHBmU1Z2SVRqdncvNFl4?=
 =?utf-8?B?c2J3RU02WThzN0JmSGRacWxjMjJheU1tT0hQempZWUhzT3JKWFJONytrVFpj?=
 =?utf-8?B?OGNJU0EySUYzamhpZ0FLd0krOHBiamh5Yzk5V2hxZXdWUXBFYUJkV0czcjIx?=
 =?utf-8?B?TC9VZkNDY2NSckZWOXFNcml0MkZackhZY3FwekUwYkh1ems0R1BDQmRGZmVS?=
 =?utf-8?B?MzkraGhuNGFKWlpNTis1c21iUjRLWkNlRk5waWN6RHdNb29XS1p6cGllREpD?=
 =?utf-8?B?NEdxZ3AzaDdXRUNLUDFDWHljSUtJcWlUdjBLUlY2R1Y2VTJUY25TYzg2bnRE?=
 =?utf-8?B?UW91NFNPQlJiNVBmRk9ON3YzWlo0Y08vV2lJQTkwY0xYejN6eGtaRmVUTXB1?=
 =?utf-8?B?ZFl5WjV2ZXhYOExTdTg2SmplT1NyRlQwL00rOEhOc3VCRjMyRjRBYVhKWkpL?=
 =?utf-8?B?SmtFcUYvR3gvWFdMb0dsQUlNWEZMd3BpTEVkamFQbG42UW15aVFkZE1JcW5B?=
 =?utf-8?B?ankzV1JQS2FhL05XcHZlekxRa3oxS1lENzJtTWhHYWt5WHF0dGZkSU9VWkhW?=
 =?utf-8?B?aDBlQ3ZSNEo1V0lqcDM2LzVPTmlCcmp1eWFsZE1TUWFYNDR0ZFNVV0RnVGFN?=
 =?utf-8?B?SXp3aEdmVytFc0ZSb2x2ZHdkVkpBSlNTaHdrR1d6Y3NBU3BVTjEvNWpxa01s?=
 =?utf-8?B?WXR4R2Voc3RUblgvRUNISEpWN1hLUGd4U0s1cHVGazFIY3NJQUxkZ0x4bWt5?=
 =?utf-8?B?SVY5eHl1QzQ4MXBlZ25TVmhjUFRORTRJaDcxOGJZQkZySXhydVhFM1NpUFVN?=
 =?utf-8?B?TjNPU3gzUUNMajNvSmpBNEF0a0NNMUwxQjJsMlRUWVBjQ2lGdzVSamlyaHVm?=
 =?utf-8?B?OHo5TjQ0K09vcXNVYXpXbjluMmx2MVpGTWFhQysrL0wwYVpueS96WjQwbENv?=
 =?utf-8?B?OWxTcVRISE5VN1RSTHV1WGJabUpTSkNOUVZrTmdQS1VNOVlSTTdwWEd5T3Ey?=
 =?utf-8?B?T3V5blVyMDRMdDljeHpBcXF6czZ0TlVrQTFhVUpTS0dmbXczbjA0M3dVbncw?=
 =?utf-8?B?K3RrOTZ6Sk9vMlc1NnNKOXNHNk5ZUVRqRXNvSHMxczZ6UTNmd3dWZFV3Rkcr?=
 =?utf-8?B?NituUGVKekpsVjFwZHltOXF2bkNUNlJKaXE5WTRnUmNpRkhSb2hMNHcvdS9R?=
 =?utf-8?B?MFJGTW53Q01pb0VWRFBrN0RUeTYxSHRxU1dQQTlEcG9ZK2JheS9Tb29BdTlE?=
 =?utf-8?B?eHNIMnFkSGwwQnFuUmp5czJxallzTEpjeTdNY2JuRHRqNHdBSFZFeU04N0hs?=
 =?utf-8?B?bWF0R3dOWlNud1ZhWWQyMGh6WjVyNzdTOW9HV1NvcTUzanQ5Mm40K0FtNHBa?=
 =?utf-8?B?YlZ1K0FpZktBOFlsWm5OK0lOczZkd0x2RWdlaVdmdlVkYkFXSE5iZTdKWmNV?=
 =?utf-8?B?YlgxeHRpWlc5cldsSDZmdVZablE4WWk3bFdDb0hLV2ZoWmZNUnZKckxhZktz?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dee4d3-bc86-4659-9021-08db88eaeb43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 06:31:15.7323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FneVUQDj2xiTmykCzsa/7KvcEzlO4iAftWEoEOPp3jEOK/Mq7RCTVsFftm2HW/UP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4870
X-Proofpoint-GUID: NQelAicZlo35TbDE2jWVhLpzN0z0PgQD
X-Proofpoint-ORIG-GUID: NQelAicZlo35TbDE2jWVhLpzN0z0PgQD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/LPYlxF_mcfRT-WSyhFauv0l791A>
Subject: Re: [Bpf] [PATCH bpf-next v3 11/17] selftests/bpf: Add unit tests
 for new sign-extension load insns
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Yonghong Song <yhs@meta.com>
From: Yonghong Song <yhs=40meta.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/19/23 5:02 PM, Yonghong Song wrote:
> Add unit tests for new ldsx insns. The test includes sign-extension
> with a single value or with a value range.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>   .../selftests/bpf/progs/verifier_ldsx.c       | 117 ++++++++++++++++++
>   2 files changed, 119 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index c375e59ff28d..6eec6a9463c8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -31,6 +31,7 @@
>   #include "verifier_int_ptr.skel.h"
>   #include "verifier_jeq_infer_not_null.skel.h"
>   #include "verifier_ld_ind.skel.h"
> +#include "verifier_ldsx.skel.h"
>   #include "verifier_leak_ptr.skel.h"
>   #include "verifier_loops1.skel.h"
>   #include "verifier_lwt.skel.h"
> @@ -133,6 +134,7 @@ void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access
>   void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
>   void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
>   void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
> +void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
>   void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
>   void test_verifier_loops1(void)               { RUN(verifier_loops1); }
>   void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> new file mode 100644
> index 000000000000..4163e9ffffe9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("socket")
> +__description("LDSX, S8")
> +__success __success_unpriv __retval(-2)
> +__naked void ldsx_s8(void)
> +{
> +	asm volatile ("					\
> +	r1 = 0x3fe;					\
> +	*(u64 *)(r10 - 8) = r1;				\
> +	r0 = *(s8 *)(r10 - 8);				\
> +	exit;						\
> +"	::: __clobber_all);

Looks like latest llvm17 is okay with the above asm syntax
but llvm16 is not okay.

https://github.com/kernel-patches/bpf/pull/5377

Will check and fix the problem in the next revision.


> +}
> +
> +SEC("socket")
> +__description("LDSX, S16")
> +__success __success_unpriv __retval(-2)
> +__naked void ldsx_s16(void)
> +{
> +	asm volatile ("					\
> +	r1 = 0x3fffe;					\
> +	*(u64 *)(r10 - 8) = r1;				\
> +	r0 = *(s16 *)(r10 - 8);				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
[...]

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

