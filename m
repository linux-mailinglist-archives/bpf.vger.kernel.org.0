Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91A64AFC5
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 07:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiLMGV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 01:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiLMGVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 01:21:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79CA1EAF8
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 22:20:45 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BD049I3025464;
        Mon, 12 Dec 2022 22:20:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qdZDsL1v2LicGLUbPKkz8LgyMrve5hz1uiXQ2PfMdRY=;
 b=WeELxuvgehIYZSaMuMs5DI5fYqccZvhlUuuGZu4dsyldH0zyZ4+mxfkkCieRkvrc/9bu
 tYgTPgC8hBb9T73kcGGTlHVXZ4T9esbOd6uDvk527woU9ZM1ZxvRFFzyvkw8795xKoTf
 8rvA8/QyQpge2IhHe1w5GY/cNhzhtLQ5KPCac8/h7zMP3y+ZEu6W23D07fIetU8DlLdq
 1LY13aVQWDh7L5lwuaEDIeAzC+J2PLv49bwI8QBOfx4/Z8eoU6lAjHTDkQKpS4l41zSk
 xIxNyi+TIzZPkXD2hbO1XoKAQU/oN8A4c44RrzIpLuTJpcm+9cCpH6i1TZE1fTWE8+GS sQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3me5fqybke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 22:20:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPqz1gcO8iFqlNno/UUFKuRfzZFUvgDt47PNs544PY4iCaCWMUaWzWhz+c2Ms62t+Hy6QRNbDyay42CiicvEQny/G9q/ar7sIpqbMdAc7QLBdsTJ5KZntWmOT3Hg7qBS7tC4/L+8UKbtmZmBeaYW2slK3+nhkRfJYVSxsgAmXedEpHCbSm2nXgWgdepe6RzfNiQhSPQ31TgtkEBRhVrw9lADzziCRCeDFTiQKNUWAHVfILLR8jy0CxWU4mSesA4T+wFO8deM+T2B3qnbZzuR5mPe/h0jYXjcGt5o0MPdk8tx01mH0Wza4Ysm71WpQrlljtZhgpzkA6A9vkYMZQo7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdZDsL1v2LicGLUbPKkz8LgyMrve5hz1uiXQ2PfMdRY=;
 b=mOX/5cLcXLcPMhl7bqafzKzPauINN+IclNPMKL5oxEReINzTsOO1WbUTGHZsHkFR9uS5WWY3IDFAPPrsRugPca4j48JD4cAvL+baMmi0RnNENmqD9mpB3TabsXN3ndRqOlTt/UUcq5z7XMMAp1yeJNjEFb1f4gMNKBKjmE8ljMUT7ViUoUHF1qxV87LKwEUSLOabx81X0stX/QDkc01ahlVnHLUrmrX8mnqbx0gPzaSeZ8QLMpA4tQ4rv1jQvK256aXQJ2GLRYnNi8oxmnUpIHZf5A/T9yvoxBOAen2fy6uEizgfOCbCQ/h0xPnYeh12DVBfCE2aJDT9vXw7E4dSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2575.namprd15.prod.outlook.com (2603:10b6:208:129::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 06:20:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 06:20:40 +0000
Message-ID: <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
Date:   Mon, 12 Dec 2022 22:20:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2 5/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc:     martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-6-daan.j.demeyer@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221210193559.371515-6-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2575:EE_
X-MS-Office365-Filtering-Correlation-Id: e1312c9d-3462-462d-b7cc-08dadcd227f7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QA2tZFyZTgj3Iun8OfNQzXZ9MTI9nsm+TRd1aTZOm2agbtKwyjaCgr5fQK2y4YqjrqwhzzaxfyQ+U34nfWIBSZJYst7BpVkux3urEPyZKg0RXKmV+MPdMIvHCvh26TVs5cMdmccwp7L2oph8W4IyEQnyvUbEPmwftNardDuPj9etPR6gWBN0H4UWf1x239K925/WsmJ8rc9EwIAyOIPfX9h8Mf0NLxriV+bLLVPx+ApPeuEoUpock5dpei13nd82qANN4pI6FHgBxuEnKs56OtxpjjAF4S/JOmC8Pj3+quSvEdwnTbtCN9CTkqnap5x3gAnNuvCG1GPTLdBQ8o0U99sAiyZLgCdP+WUkE1VtpKcdhifgaYXMzarolRoMEJOh6rOkXjUeCiCVfXxywo9ru+U79/gyco8fP8HgD/sZCOdNjhKPOhDbFqRjQHNHulC0mQcSgHNDEeL2wpxa0fKYBa3DhqtlwvUAYxTGt7ESsov+wjPHRJobKjjZNwZkNzABGI18TsdoUpHF2DZyUbzTZuLcHCp3ZDnfsD/C+OLJX36HYGuw+OLRyKFQIe+bb4n72yyB+nWS2Y8/pOkf/Iql2sMjsbCkZp8BLmJbVLdwUKWEYRUt5oXmZihwnm1bRKaV3TeoQc61QzitYd9kj3MiZ3BM2yieRhiM+xiZYHtPiQN67MrZO+fxxxrfqTzzVgCZQl7hjTW34wc2iq332jE+3PsHv8PlUjzX2/yokAMpLNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(6512007)(6506007)(53546011)(36756003)(186003)(478600001)(6486002)(107886003)(6666004)(31696002)(86362001)(38100700002)(83380400001)(2616005)(66476007)(5660300002)(66946007)(66556008)(30864003)(31686004)(4326008)(8676002)(8936002)(41300700001)(66899015)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEtEc2pZVVBhdWhIUWxLdEhuNS8zOFNDV0FKYjZyS3BPRm01VUNZc3ZjdUxV?=
 =?utf-8?B?M3M5c0RQS1R6RWlvK05lRVNEMDNveDA4OVMxZmFsTTkvSnVZOHFxN3hqSGgr?=
 =?utf-8?B?NXlTOHdIUVFaTEY5WnQrd21rQ1lKNXRLa2FiVEhiZkNaYnExU0ZaRFZwSmdP?=
 =?utf-8?B?M0Y3a04xUXRxUW56UFRDOUxCRnZ0Rkg2RVJoM2t4N1ZwMW9FOW1ZSmNHcllI?=
 =?utf-8?B?MDJzQzdYMkRKR1F0Vk1RaWZBOWtlMGQ4Y1FZdEpTeVhtTmlZdUJMSm43UnR3?=
 =?utf-8?B?VldJQ1ZkTHpCUW9KLzRyQ0dUUi8vVXh0Z2V3NHU0ZlNUQlJYbzBJbnpxTGJu?=
 =?utf-8?B?U2VaYm0wMHZaZi92YnUrbGRsckVNMHBVN2tWUEVDNUZFeGJ3VzBzd0hoZUpJ?=
 =?utf-8?B?RUhacDJOOFhhYzVHckV5VDF3NUV2SmhxUHFkUit2SjRzblFkcStGUUNKcHFN?=
 =?utf-8?B?aGErcnBEYnhHcHBQeFJkT1JKVi9OZnNuTGl1YnNxVFRuUU56cEdhaUh3elV0?=
 =?utf-8?B?QTV3cFBGUmNDUmd3YjhIeFY4V3BFYkU5UG4wVy9JKzhOcE5UR3l3N1BHMzgw?=
 =?utf-8?B?cTJTbFZlcHFCOENIMmR4WXZtVVlXRFhxNzR5Lys1NzlsOEhUcnpXa3h1cmNG?=
 =?utf-8?B?UXVjOHR1QllTMXQ2UzRuVldPK3B4RGx5cjZvVFI3V2pkaTkrV0NxYU8wT0Zo?=
 =?utf-8?B?ZGxpNU1wKzg4NlcwbFZIUmtCWXJ4YThweEthSUF6Nmo5UExnaU92ZXdLUFVm?=
 =?utf-8?B?STZhTUk4SmZ4S2FwZmxncGsvbmFVZmdyalNqa2M4c043ZStNVzdwdm54Vysr?=
 =?utf-8?B?MmRqdVVqVFZWN1dXYlAwQmErSWxKVHZGZXhpMUZYdCtQMFZHcjFwNHZQcWJV?=
 =?utf-8?B?a0tDTnQrQmZUcVphVjNFL2Uya3BhY1VpM3EwckltYjZpMldWNkNOcnV1QWpT?=
 =?utf-8?B?SUZ3UjFCRzNDUmxDZlhjN2podGpDdWFzYUtkQkxmaENzbnU4UzNqUXhNaXZV?=
 =?utf-8?B?bzBOSVcvL1RGZTJ4cGNmajRIYWxLbW5kNlYwSElzaHdwczduWC9uVEpXQzBK?=
 =?utf-8?B?L01KdjFnL0NDMFRwRXRxSVlveUkzdzAwcmwrb0xEUUJQWE1GalBVTkJCdE5D?=
 =?utf-8?B?MVN0QlNJOVNEWUo0WXFwSzl0c1RQYVVJMjhrSDl0dWdrWTdSbWpUeDNSNXVJ?=
 =?utf-8?B?SHdZWUVXcUlrSWxkcVozTTUzc1l3THVYN3MvZENHeGRvWGpNNHNTZDZlbGsz?=
 =?utf-8?B?RmR2cDZ2djIzRnIxL2l4WEFtSXI3cDlJb2FkMEZOdlMrdFo1N1plNDhKYm52?=
 =?utf-8?B?Q1AxWG15UHNid2Zkc1lzQzIzbUliOCs5SWJkcTl2KzNJcE9pbks2Z2daVm9j?=
 =?utf-8?B?cVRJcE1SMlZzTUphQkpZUWJRSk5VOG9MUEJyU2diUCtadndwSk9IeVdjREZU?=
 =?utf-8?B?bVM1Nk9qNWl4TzVML0NMMXgzT2lZdm5DcWVZdE1rOHF5Zno0VXJxd3NwWTht?=
 =?utf-8?B?bmRsTm9zdTFsekt2bFByOGJ4RUZjZ09HTVljOXByQzgvbUhiUE5WMTNNc2p0?=
 =?utf-8?B?VXBLUDh0aDUrdHJ0TEM5TkI3ckJaRkthOE4rOHg2SE44bEViOWZ6ckxwaWgx?=
 =?utf-8?B?TTFBL09lY01lYlVJL2RrT1VDK253MldBaWVVTVEwNFp6MC9tajhMM04xckJp?=
 =?utf-8?B?NDBwRzFCSmJyMmZ4anUxa0grNFpTMUdxVFVQdkV2Y3ZyNWQ4NXpRZ3JkZ3Ir?=
 =?utf-8?B?K3Rkd3BKQzRuMHBhTmc2NVB6WmExNEJjVXlaQXhuS3pmN2xrY1JxZXpQSDB3?=
 =?utf-8?B?K08wa1FSTnJ3dVoxWm1FSVhkaTVYUVdkTlhlMFRXazNoT3M5YkY0Uml5bmVa?=
 =?utf-8?B?L2FLK1ZwelZTVElnbDdXMjlncGFUZGpkVTQxUmhSN2ROU1BvdDBDRXJwQjhM?=
 =?utf-8?B?dkRrcEYyODFDR0szQlNEU3JrWFRzdzlKUzdjSjRiUjlOT0ZyVWJTUms3R0hT?=
 =?utf-8?B?SExJZGV2dzJkYktjMGczL1pBZmsyeTVibm1SSENXNjNWV3NCNkk1OEhiZlJL?=
 =?utf-8?B?aTRRWjRhVHVub1pLMFpLY1EzVHJ2U2JkUnMvb2FQZHUyVXZ6dk1OR2JRT2M1?=
 =?utf-8?B?Umk2N1RxMW1MNjZtczdyaXU5cGdrQnJXVm81VlNGdW5FRmRFbkh4dXJRYmhL?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1312c9d-3462-462d-b7cc-08dadcd227f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 06:20:39.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX8OaTmDRoVEyrWU8N3o3CIh5g1kJgu9c+oDmyJjUGpMbf5WOJJPRSGOTRIUcAPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2575
X-Proofpoint-ORIG-GUID: 5LDmvdcxhGL94s3jfAiZd1jTcfDKCdYD
X-Proofpoint-GUID: 5LDmvdcxhGL94s3jfAiZd1jTcfDKCdYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/10/22 11:35 AM, Daan De Meyer wrote:
> These hooks allows intercepting bind(), connect(), getsockname(),
> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> socket hooks get write access to the address length because the
> address length is not fixed when dealing with unix sockets and
> needs to be modified when a unix socket address is modified by
> the hook. Because abstract socket unix addresses start with a
> NUL byte, we cannot recalculate the socket address in kernelspace
> after running the hook by calculating the length of the unix socket
> path using strlen().

Yes, although we cannot calculate the socket path length with
strlen(). But we still have a method to find the path. In
unix_seq_show(), the unix socket path is calculated as below,

                 if (u->addr) {  // under a hash table lock here
                         int i, len;
                         seq_putc(seq, ' ');

                         i = 0;
                         len = u->addr->len -
                                 offsetof(struct sockaddr_un, sun_path);
                         if (u->addr->name->sun_path[0]) {
                                 len--;
                         } else {
                                 seq_putc(seq, '@');
                                 i++;
                         }
                         for ( ; i < len; i++)
                                 seq_putc(seq, u->addr->name->sun_path[i] ?:
                                          '@');
                 }

Is it possible that we can use the above method to find the
address length so we won't need to pass uaddr_len to bpf program?

Since all other hooks do not need to uaddr_len, you could add some
new hooks for unix socket which can specially calculate uaddr_len
after the bpf program run.

> 
> This hook can be used when users want to multiplex syscall to a
> single unix socket to multiple different processes behind the scenes
> by redirecting the connect() and other syscalls to process specific
> sockets.
> ---
>   include/linux/bpf-cgroup-defs.h |  6 +++
>   include/linux/bpf-cgroup.h      | 29 ++++++++++-
>   include/uapi/linux/bpf.h        | 14 ++++--
>   kernel/bpf/cgroup.c             | 11 ++++-
>   kernel/bpf/syscall.c            | 18 +++++++
>   kernel/bpf/verifier.c           |  7 ++-
>   net/core/filter.c               | 45 +++++++++++++++--
>   net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++----
>   tools/include/uapi/linux/bpf.h  | 14 ++++--
>   9 files changed, 204 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> index 7b121bd780eb..8196ccb81915 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -26,21 +26,27 @@ enum cgroup_bpf_attach_type {
>   	CGROUP_DEVICE,
>   	CGROUP_INET4_BIND,
>   	CGROUP_INET6_BIND,
> +	CGROUP_UNIX_BIND,
>   	CGROUP_INET4_CONNECT,
>   	CGROUP_INET6_CONNECT,
> +	CGROUP_UNIX_CONNECT,
>   	CGROUP_INET4_POST_BIND,
>   	CGROUP_INET6_POST_BIND,
>   	CGROUP_UDP4_SENDMSG,
>   	CGROUP_UDP6_SENDMSG,
> +	CGROUP_UNIX_SENDMSG,
>   	CGROUP_SYSCTL,
>   	CGROUP_UDP4_RECVMSG,
>   	CGROUP_UDP6_RECVMSG,
> +	CGROUP_UNIX_RECVMSG,
>   	CGROUP_GETSOCKOPT,
>   	CGROUP_SETSOCKOPT,
>   	CGROUP_INET4_GETPEERNAME,
>   	CGROUP_INET6_GETPEERNAME,
> +	CGROUP_UNIX_GETPEERNAME,
>   	CGROUP_INET4_GETSOCKNAME,
>   	CGROUP_INET6_GETSOCKNAME,
> +	CGROUP_UNIX_GETSOCKNAME,
>   	CGROUP_INET_SOCK_RELEASE,
>   	CGROUP_LSM_START,
>   	CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 3ab2f06ddc8a..4de3016f01e4 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -46,21 +46,27 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
>   	CGROUP_ATYPE(CGROUP_DEVICE);
>   	CGROUP_ATYPE(CGROUP_INET4_BIND);
>   	CGROUP_ATYPE(CGROUP_INET6_BIND);
> +	CGROUP_ATYPE(CGROUP_UNIX_BIND);
>   	CGROUP_ATYPE(CGROUP_INET4_CONNECT);
>   	CGROUP_ATYPE(CGROUP_INET6_CONNECT);
> +	CGROUP_ATYPE(CGROUP_UNIX_CONNECT);
>   	CGROUP_ATYPE(CGROUP_INET4_POST_BIND);
>   	CGROUP_ATYPE(CGROUP_INET6_POST_BIND);
>   	CGROUP_ATYPE(CGROUP_UDP4_SENDMSG);
>   	CGROUP_ATYPE(CGROUP_UDP6_SENDMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_SENDMSG);
>   	CGROUP_ATYPE(CGROUP_SYSCTL);
>   	CGROUP_ATYPE(CGROUP_UDP4_RECVMSG);
>   	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
> +	CGROUP_ATYPE(CGROUP_UNIX_RECVMSG);
>   	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
>   	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
>   	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
>   	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETPEERNAME);
>   	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
>   	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
> +	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
>   	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
>   	default:
>   		return CGROUP_BPF_ATTACH_TYPE_INVALID;
> @@ -273,9 +279,13 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   		__ret;                                                       \
>   	})
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen)			\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_BIND, NULL)
> +
>   #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk)				       \
>   	((cgroup_bpf_enabled(CGROUP_INET4_CONNECT) ||		       \
> -	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT)) &&		       \
> +	  cgroup_bpf_enabled(CGROUP_INET6_CONNECT) ||		       \
> +	  cgroup_bpf_enabled(CGROUP_UNIX_CONNECT)) &&		       \
>   	 (sk)->sk_prot->pre_connect)
>   
>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen)		       \
> @@ -284,24 +294,36 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen)		       \
>   	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen)	               \
> +	BPF_CGROUP_RUN_SA_PROG(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT)
> +
>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET4_CONNECT, NULL)
>   
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_INET6_CONNECT, NULL)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)	       \
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)
> +
>   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_SENDMSG, t_ctx)
>   
>   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)       \
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_SENDMSG, t_ctx)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx)	\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_SENDMSG, t_ctx)
> +
>   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP4_RECVMSG, NULL)
>   
>   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
>   	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UDP6_RECVMSG, NULL)
>   
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen)		\
> +	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_RECVMSG, NULL)
> +
>   /* The SOCK_OPS"_SK" macro should be used when sock_ops->sk is not a
>    * fullsock and its parent fullsock cannot be traced by
>    * sk_to_full_sk().
> @@ -487,16 +509,21 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>   #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_BIND_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_POST_BIND(sk) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_INET6_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk, uaddr, uaddrlen, t_ctx) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 9e3c33f83bba..b73e4da458fd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -999,17 +999,21 @@ enum bpf_attach_type {
>   	BPF_SK_MSG_VERDICT,
>   	BPF_CGROUP_INET4_BIND,
>   	BPF_CGROUP_INET6_BIND,
> +	BPF_CGROUP_UNIX_BIND,
>   	BPF_CGROUP_INET4_CONNECT,
>   	BPF_CGROUP_INET6_CONNECT,
> +	BPF_CGROUP_UNIX_CONNECT,
>   	BPF_CGROUP_INET4_POST_BIND,
>   	BPF_CGROUP_INET6_POST_BIND,
>   	BPF_CGROUP_UDP4_SENDMSG,
>   	BPF_CGROUP_UDP6_SENDMSG,
> +	BPF_CGROUP_UNIX_SENDMSG,
>   	BPF_LIRC_MODE2,
>   	BPF_FLOW_DISSECTOR,
>   	BPF_CGROUP_SYSCTL,
>   	BPF_CGROUP_UDP4_RECVMSG,
>   	BPF_CGROUP_UDP6_RECVMSG,
> +	BPF_CGROUP_UNIX_RECVMSG,
>   	BPF_CGROUP_GETSOCKOPT,
>   	BPF_CGROUP_SETSOCKOPT,
>   	BPF_TRACE_RAW_TP,
> @@ -1020,8 +1024,10 @@ enum bpf_attach_type {
>   	BPF_TRACE_ITER,
>   	BPF_CGROUP_INET4_GETPEERNAME,
>   	BPF_CGROUP_INET6_GETPEERNAME,
> +	BPF_CGROUP_UNIX_GETPEERNAME,
>   	BPF_CGROUP_INET4_GETSOCKNAME,
>   	BPF_CGROUP_INET6_GETSOCKNAME,
> +	BPF_CGROUP_UNIX_GETSOCKNAME,
>   	BPF_XDP_DEVMAP,
>   	BPF_CGROUP_INET_SOCK_RELEASE,
>   	BPF_XDP_CPUMAP,

This is uapi. Please add new attach type to the end of enum type.

> @@ -2575,8 +2581,8 @@ union bpf_attr {
>    * 		*bpf_socket* should be one of the following:
>    *
>    * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>    *
>    * 		This helper actually implements a subset of **setsockopt()**.
>    * 		It supports the following *level*\ s:
> @@ -2809,8 +2815,8 @@ union bpf_attr {
>    * 		*bpf_socket* should be one of the following:
>    *
>    * 		* **struct bpf_sock_ops** for **BPF_PROG_TYPE_SOCK_OPS**.
> - * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**
> - * 		  and **BPF_CGROUP_INET6_CONNECT**.
> + * 		* **struct bpf_sock_addr** for **BPF_CGROUP_INET4_CONNECT**,
> + * 		  **BPF_CGROUP_INET6_CONNECT** and **BPF_CGROUP_UNIX_CONNECT**.
>    *
>    * 		This helper actually implements a subset of **getsockopt()**.
>    * 		It supports the same set of *optname*\ s that is supported by
[...]
