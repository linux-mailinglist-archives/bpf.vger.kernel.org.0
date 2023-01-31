Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A46832CF
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 17:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjAaQfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 11:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAaQfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 11:35:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255922704;
        Tue, 31 Jan 2023 08:34:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEDrvq003524;
        Tue, 31 Jan 2023 15:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oJr83XlPOmvF7Dn83KPvY2DVOJpfy1TBPpJPJm127Sc=;
 b=cAMXbfaUDDPe1+IPyv+rQA0bkErEPH+aBsgNL1CYWuTE7TcFo2uwJ5RVNl12xb7toVwe
 VcRXOsmas6oC5mqwIzRupU268A3A3GtgMjfgfhgn9Kvo3p08f7lPPviT4b8MfTBMTizr
 4T62x9CEKiLP0Xw0hYg9CWpPBJFtQdZMDw2LddaxnWMQcjwltUU1Rn9gJ7EdOndk3fqP
 W000nTQD8O6cskQiRRssNNWfiLeCOul5bsnZIIs5TUSVf212NOibwO4ik8vLIoiMYzYB
 VPv8gdzp/3oBZPrVA2KuVc7Eug9XN9GC0cJi5iVFKP5H4M5ozeTU8yuF4uaEr//FtzND BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm15vbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:15:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VFCtGD020345;
        Tue, 31 Jan 2023 15:15:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5ckmjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:15:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoiX3pgRW38B/ShBDVkES8mLkA05s+SFDKuHHJwasJ8ozFSYW2vZBbFZvT6H9dAF2zSs5JyiRB1CgiPMaWH9scCIEkdRqD0waZnNen/LeOZI8pOlGPURsoKLtc9ZjZDbiRST8DKty0Wn1LEoIyqAV5U4+cq0/800xFVIXbuAf7vam0GWLbMAzB2MoYx0/cgd9jGBG7zRZLgj9TDAJMXGlUUmBEZOvMO6xz8iD2l+4KbiT+f6bAIGNY2FFwjcSr6XU9/E7F8LpwMowLIhsJYeD4W48i6DGL27x+7Fxei3wcCmSwbEANgVNXL7zxmkBemiAuOC7DoUeBJZKoxNFGg73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJr83XlPOmvF7Dn83KPvY2DVOJpfy1TBPpJPJm127Sc=;
 b=SY86so4zyU+LLtrZ5j0wyJrSMIEH9ZZy/M7wWhi7tLghoot/eVNZgXw6VnKCe33I4Q6VyZV6VGAsYeskdLweXB7hbdnZr2fv2oZ5OljC8BwgjTCW4WZGHo1mEEqWtYYSktlQ/YdLqjRV+BO5Mk2L9w1uTODMBaksHftdesYCgmRBOO3RxiUEK4Rp9//IA2zSI/ta4WDvk2WRMYrgeKyAoG0gdHhSz360FUqgNYanZL76LZ6w27fAAp5izl+mMMMLydFvS+dC5m2hO9LVDE1NqF+m/tEM+0cd0Z2f3NqDA9TKFUG5N+9H+HpfAnr5Y3YEtzj53CTZjfHpoChUTmKZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJr83XlPOmvF7Dn83KPvY2DVOJpfy1TBPpJPJm127Sc=;
 b=eLvaoLZsZcL9RulYPJBohAwO4Xaqj2Xw5fo/sb14enjiTeLhD0zqaC/oyOvHiJx1xja4Nf37znYHJ2d66tls62lsaTX8Tv0Fr55ipjoq1iJMmw/5FnZZcn0TDx5m1yV+mh69IhP01N5St8mN9dIiKVcUF7Q9ELQgicLsXksRsIg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 15:15:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 15:15:31 +0000
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
To:     David Vernet <void@manifault.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com, hch@infradead.org
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
 <87o7qphspq.fsf@meer.lwn.net> <Y88sMlmrq0wCFSRP@maniforge.lan>
 <87lelsgf60.fsf@meer.lwn.net> <Y9AFT4pTydKh+PD3@maniforge.lan>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7cecda8c-9499-4fc1-784c-4e6174122a1f@oracle.com>
Date:   Tue, 31 Jan 2023 15:15:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9AFT4pTydKh+PD3@maniforge.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 501c22c6-c514-4cd1-c9ec-08db039dfe67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4yL69+HxDqsJkfVxaV7bDDuop86zCp2F7EzF81LXAMaUxvDWeExj6HyuRLaeqvXkoznIP2RESHeYxhuE6t4Ya1KiXl1zyQ9q6NUkvE7WwTFc0qFlgUZNax3LXCNDds7VGL8zAnuOooBnfXZd2nNLcaegAOWI6cYkxRYaRcLROfydh/KjqZdkJKtjAAYfy87/ytjsmMGeAm4BElrXfI2nB1Nl2mQFQeA8d9Qt1PBRTD8alfJcEwM4LJzwXjuCba+U/yuCcWPvSYqpHQETI9WR8LKiNnh4q6c5gJYgH58LQeJDEXfQI5Imc/3xnvIqDWcRmAg+8OEi057SmCDVtss/cAYa7zf1r/BGpzlmQ25/z505bLe9PUICNZzAhdNXKE1F0jI9A03oXQxyVHY+X/OP6s3Z4LvDnYxVwpjtCAtywVFLFDmOyH7Miuna17nLnpGmRrocwolN44i/9A3lStzN5bZkPlyjXfeuWftkmGeyZWUuzpgWPfhCWlaMG1jfMV7Y534AtDU2Z2vqT6UaPwVQ8V7LUpW1lVJrgvDvFIIrerdtEtoIRmX9WyxeDSa3X0lJzAi0O8soanmCILP1l0rfUEWOHLiKEG6rZ9wzYHVh0CdXozbFpbX//N5pS1B9D/5ukZMvcEIUtC2cx9zNyk/5ExGRTNCOEO9uInBXXHk3PK7edUR3K+TDN00N6if0ukMUKyChyVVZe0e2bZVB2z09jMwqAHUTSc7YsCcjXSmmbLYmmuoSHl+jwfvrL0M3uFBuu2JhcrKimIAmBGQ4TlqPZeezWJb5Xb+ncEy9vAA7TH+gctc/WnXcq/Cfhha4h5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(2906002)(478600001)(44832011)(31686004)(83380400001)(6506007)(53546011)(7416002)(5660300002)(6512007)(186003)(966005)(36756003)(2616005)(8936002)(41300700001)(6666004)(6486002)(31696002)(66556008)(86362001)(8676002)(66476007)(4326008)(316002)(66946007)(54906003)(38100700002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZGVDRtQ0p0N1lSamtwWGpXOE1GMDRTZmFYeklUWDZCb0hxYkJJUVEvK2xz?=
 =?utf-8?B?dWRGTWhpNGNmczJQQTkzZmNIVDVrQVlWZ09Ud1Rwbi9aL2M4UzNtVnFzcEZj?=
 =?utf-8?B?RWZWdWJSMWkybzAvNVJOR0NFdVN6cllWUnZ1aEpNbWt5ZDQ2OXBVVUd6WU1r?=
 =?utf-8?B?OHhLT3NkbmorZjEvU0tyQVZLRXZxK2FzcGZuOXVUYnJld3pIaTBTR2MzeHRN?=
 =?utf-8?B?Q3pQbEE1T01JZytLSXc5YUxpRU43YWFYL1k0ZlUzVW4yUlZDTWhNbHM2UlV6?=
 =?utf-8?B?cWVxUGhtQ1NDZU85cTJwRVE0YmlwZE9aMkJla25UM1dYa2ZLRVJMSWlBV3FZ?=
 =?utf-8?B?ZDkrUjNQekpHZ1lFUWpZUmRNWmd5TURMU3AzOTJTb3RNdmpYb1JqOWR5YVRP?=
 =?utf-8?B?NUFJSXhNTmJUcWYzUG5LZkVCdUpXaGVWRWI5amM3ZEdRYWVMeUxwY213ckR3?=
 =?utf-8?B?ZHFxWnBKQzNYT28vM3BYQnJsWm1LL2o2cVZCNkxBVFhxTTVjcXhGMnF0TGNL?=
 =?utf-8?B?bEdPalJBRDRLZ2p5bnMyTkducE53UHNYUnIxOEV5VkUrYlN3YlhXOG5nSHdu?=
 =?utf-8?B?ZlFhUUJraVFlQ1Rjbm9kQVVqbUFLNkduNE9UcW92Y1pacmF0bEk2TzEwVUpa?=
 =?utf-8?B?VisrTTBUUGc5UHhDTjBmdWhnQkpIVzhNSHZwcVc1NENGWW55ZGt5Z3ZYREUy?=
 =?utf-8?B?NW9ObXlBMUEyQnpZbDByV2Z3aDVINVY0Q3liNFJBYy9CL3AwTVZaWXJNZndn?=
 =?utf-8?B?ams2c1E5UHlGVThwb0R0NFNrTzFaNFBla0xqL0dIdlcrMjE5bEFvaGU4OExq?=
 =?utf-8?B?MUJpbEV5aDQwMGxJZU4zV29lTHZuN3Z3SDIyb2RWRWdCSWd2OVB0TGJIYnp5?=
 =?utf-8?B?cUY4R2FIQkNKaHdqR0NIKzdDaXY2bUJnWjN5UVpYK3Vkd2pvdkpWUG02VVd6?=
 =?utf-8?B?NjBSVXc4ME95Z1o0UENRUTdpZ1lGZHFGYW5lQWFCeW5TWTJRT3ZJUG13Q2tI?=
 =?utf-8?B?TmxiTHRiM3lnQ0hFZCtXcVpXaG5KM2c3d3p2MWcwMTQ1ejJTMnBoaHUrdXpV?=
 =?utf-8?B?ZHFVWWx0NFduN3Z6NEtuODJyOHpsc1hoR2U4SDRtYS83VURUV1dJRjVlNHg4?=
 =?utf-8?B?eVNodTN5UDV3Z2F1ck9hS0JJa2ZIMTlJaCttcys5TnVGUENEbk83TUZEMmVa?=
 =?utf-8?B?dkhwSkQyYTdjZnBRcmMvaDMzQVhwL2pwaEh1dkpZek1kaTFWaVdTWk9udkdM?=
 =?utf-8?B?MXVNWVVnTFVrd3ZnSS9WYTh5UklOTHU5MGZoNDVqRlkzWmw3MWJwTW05YTNN?=
 =?utf-8?B?SVNSUkVPbWVQMUsvL1hpa1RnYVVRdGpNaTNZTHZOYk1DUVZqL0RiOGRvZU5V?=
 =?utf-8?B?SWtTaDdGb3didTgycG9wTTNNSmQzR0t1MTI2aXpLQUMyL1pZbnpHWG1aMkd2?=
 =?utf-8?B?eG9hS2YwY0IzQzkxZ1psdU43RmM4VGhZZDJhNFZOVU9RRnBCL016dXRNYWU5?=
 =?utf-8?B?bWVlSWd0ZGRmazBJUnlINFYxRzFNSTA2QlZYWmVvRWhlZ3ZYcWs0d1VpZlM5?=
 =?utf-8?B?T3FlcjdKOU8zWEtJc1dCdGVsMFVTbnB2TUhFcC9GYXNUV25ycHMreERlUUkr?=
 =?utf-8?B?Z1ZUZG9oeml6UWY4S28vc05CMUlQNE04TGpaSnQrb0hPamJTb2xVT0ZUb3BM?=
 =?utf-8?B?Vlc2RjRtaVozSmt4OWpJdEpSaEIyUTRNcDcvZUVpemQ1MndLL0pVMjVZVTFE?=
 =?utf-8?B?RGg1cVZ3dTYrN0E0TEpkRG9KbGhtY1RDVnBGdmdCSVNuSVFoNVdDVDNONzlu?=
 =?utf-8?B?T25wTW9BLzlOcnhlUmd6MnIrMEpORlpudE1XM2h1amk1ODhVWkRPd3J6SzhD?=
 =?utf-8?B?bHJsbGZCSXBrdVl1UGNmVnJtZ0N3eXloTzdmWEFGNU9FWjlmWFlDZ1JyVzBq?=
 =?utf-8?B?eWZDVU85QkN1QjlVZE8yemh2M1Q1SnE5MWd4cGhPdk5xKytYcGozNGxRTThT?=
 =?utf-8?B?MnA0WkNJbGtCZjV3Qm4vbXlITm5QMkVEUTVuMENXTTQ5bU8vN1V4NGJUbU1K?=
 =?utf-8?B?eXBEMksxd0djM3d0UDNOcGJJTWdxdUxKZ3RxMm5mdGNPWTVMNkg4aXU1RHVn?=
 =?utf-8?B?Y2JJYXVRWXhGMzJKOTJIOGJtRnZGVnl3NUw0RmlYVVFmcmZVdjlrWVNDZnpj?=
 =?utf-8?Q?clrICWRHX9RsLCVxD85BgRg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R1hyQjk4ckFrYzBKelp0cklTMzNzUkVjd1J0TGVXemc5dDRLai9EbGNzZXAx?=
 =?utf-8?B?RVYzdmdPU0lEZS8zeFd4Wnp0YytlaHVsYkhpTnhPVXFoYWN1eU4xOXBIbUpy?=
 =?utf-8?B?QW9RQWVUWW5BV0ZMRWFZNVRnNnNheDF5Zm51ZUltT2cyeVljUmIxRUV3Wmgw?=
 =?utf-8?B?ZlRxMS9neG9XV1FSMStLZE9HK2VuSDVmV05yNkVOYmQvSVFXd2hqZWdkQzRp?=
 =?utf-8?B?Rk5BdklBclNxVWw0bk5EVFpDdTAxc3VUdE4xQUpSK3pBOVIxR3dVd3F6SWt2?=
 =?utf-8?B?QURGTVB3TGxBQ0JPYzVGMmJnNTdubXduK2QrTUJqdEhxR0tvbFovSzRDQm85?=
 =?utf-8?B?ejdONS9pWFcvNU0yNmdRNExvOGNPbVBrTDZ4VDJVSmZiZXd6RmRJWWNzYlQz?=
 =?utf-8?B?Y3d4Q0NVWi84d0ZqcW1LZy82cGU4TGFVUHMyc1g2bWRjSEV2Njh2RGE4YWZw?=
 =?utf-8?B?UjJvckg0S2Z1Smd6WHgxQnpXamRLTGpBMW5XeE9RTWZOSTRDYVRPL1pTUmp2?=
 =?utf-8?B?Szl6ZEplQytKOTRuV1MwcW5JdzVCU1FmMXh6YWhnb0FFUlQ5UndHbjdNaGZm?=
 =?utf-8?B?TzRvTE15bEhHMDhnYTdhK0RTcVhHUUpTUDd5OXpJeEh6b0ZieXdkQmFzVkUr?=
 =?utf-8?B?clZMeVBBR0pVVERqSlpObi94cml6ZGw3aWQyVEw4UGgrTjdLaE9YdDkvVUpi?=
 =?utf-8?B?dElBRmZJVithc05RVndkdUwxbmhFd29KVWt6dTdhVU1EcE5hUUhEcWZEYmpM?=
 =?utf-8?B?Ynl2OTRqdExQYjc2MWhDVTV3amZSQkY0RG5OT2FmeSs4dWtZemNjTTRHVHVo?=
 =?utf-8?B?ZmpIQmtVM0VJRHNKRkduUGgyejBsNkNyL2ltM0Z2SGp6a3BDanEzemlJcm1Y?=
 =?utf-8?B?OEwzakk2eXpUZ2NQcS81YTZBZnVIUHZGY2hRdGk5OHluK2ZzOFhIZUYwT004?=
 =?utf-8?B?VmZTT25jelh3WE9hODV5UXlPMDBDQjZlOGRLZlQvSmFzRDZmR05OTjgwMDR3?=
 =?utf-8?B?ZEN5MFBLTkMyc1ltN0JTZlF0UnFvN1ZyckVTMys2SzlmUkIvVmFReVk3K3pE?=
 =?utf-8?B?dllENllqMTdXVEh6NGRiandsRGlOYWtidTFES0E3U2RvUVA2aFFTL3RwTDZl?=
 =?utf-8?B?MXNaMUdCdkVZeXZuYUlSL0hUYmFDcWxLVWdWMXNWbVJGUkhNMlBza2Zld3B1?=
 =?utf-8?B?QnhqcUxBeVFmUk9KejBNMXkwaEZNeHJXaDdtL0NjNWNlN1FINEZ4MjVFMGZI?=
 =?utf-8?B?N05RWVkwc20va0NmRkdFbXZTa1YwOStmSmhKRktOWXBuYjZidHRRT0ZmRU5D?=
 =?utf-8?B?SDRMSFhrTjltNG51d3VxbkNTZ3VaNjczZnNqZStzZ2pVWDRPWUlFTmFRTDZZ?=
 =?utf-8?B?amlIZXpDQUVFZ1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501c22c6-c514-4cd1-c9ec-08db039dfe67
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 15:15:31.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COuD4jvoTgdeRn+NPrsP/sYt58LGtIk+SIvn/r5qJRYmnq5A56NBRAhyuLlm8ovh2SAJhIr6Umpm10ma3IH+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310136
X-Proofpoint-GUID: ivAmFawZFmZevAkLIHZ3h7phXxdwGlX7
X-Proofpoint-ORIG-GUID: ivAmFawZFmZevAkLIHZ3h7phXxdwGlX7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/01/2023 16:20, David Vernet wrote:
> On Tue, Jan 24, 2023 at 07:50:31AM -0700, Jonathan Corbet wrote:
>> David Vernet <void@manifault.com> writes:
>>
>>> I was perhaps a bit naive to think we could just throw a __bpf_kfunc
>>> macro onto the function signatures and call it a day :-) I think it's
>>> probably best to table this for now, and either I or someone else can
>>> come back to it when we have bandwidth to solve the problem more
>>> appropriately.
>>
>> Now I feel bad ... I was just tossing out a thought, not wanting to
>> bikeshed this work into oblivion.  If what you have solves a real
> 
> No apologies necessary. I don't think this qualifies as bikeshedding.
> IMO folks are raising legitimate UX concerns, which is important and
> worth getting right.
> 
>> problem and is the best that can be done now, perhaps it should just go
>> in and a "more appropriate" solution can be adopted later, should
>> somebody manage to come up with it?
> 
> That would be my preference, but I also understand folks' sentiment of
> wanting to keep out what they feel like is odd syntax, as Christoph said
> in [0], and Daniel alluded to earlier in this thread.
> 
> [0]: https://lore.kernel.org/all/Y8+FeH7rz8jDTubt@infradead.org/
> 
> I tested on an LTO build and wrapper kfuncs (with external linkage) were
> not being stripped despite not being called from anywhere else in the
> kernel, so for now I _think_ it's safe to call this patch set more of a
> cleanup / future-proofing than solving an immediate and pressing problem
> (as long as anyone adding kfuncs carefully follows the directions in
> [1]). In other words, I think we have some time to do this the right way
> without paying too much of a cost later. If we set up the UX correctly,
> just adding an EXPORT_SYMBOL_KFUNC call (or something to that effect,
> including just using BTF_ID_FLAGS) should be minimal effort even if
> there are a lot more kfuncs by then.
> 
> [1]: https://docs.kernel.org/bpf/kfuncs.html
> 
> If it turns out that we start to observe problems in LTO builds without
> specifying __used and/or noinline, or if folks are repeatedly making
> mistakes when adding kfuncs (by e.g. not giving wrapper kfuncs external
> linkage) then I think it would be a stronger case to get this in now and
> fix it up later.
>

hi David,

I think I may have stumbled upon such a case. We're working on improving
the relationship between the generated BPF Type Format (BTF) info
for the kernel and the actual function signatures, doing things like
spotting optimized-out parameters and not including such functions
in the final BTF since tracing such functions violates user expectations.
The changes also remove functions with inconsistent prototypes (same
name, different function prototype).

As part of that work [1], I ran into an issue with kfuncs. Because some of these
functions have minimal definitions, the compiler tries to be clever and as
a result parameters are not represented in DWARF. As a consequence of this,
we do not generate a BTF representation for the kfunc (since DWARF is telling
us the function has optimized-out parameters), and so then don't have BTF ids 
for the associated kfunc, which is then not usable. The issue of trace accuracy
is important for users, so we're hoping to land those changes in dwarves soon.
 
As described in [2] adding a prefixed

__attribute__ ((optimize("O0"))) 

...to the kfunc sorts this out, so having that attribute rolled into a prefix
definition like the one you've proposed would solve this in the short term.
There may be a better way to solve the problem I've run into, but I can't
see an easy solution right now.

Would the above be feasible do you think? Thanks!

Alan

[1] https://lore.kernel.org/bpf/1675088985-20300-1-git-send-email-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com/

 
> Thanks,
> David
> 
