Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443F84436FC
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 21:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhKBUOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 16:14:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8862 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhKBUOT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 16:14:19 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Hmo9H025025;
        Tue, 2 Nov 2021 13:11:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=A90SG/L/tv8ncKltVgBHttXpKjZZiePgoiQGYap0ElA=;
 b=D+bvycjc+S5i+DcJL2eS+MHB9ojh5nUOo6LDUc1xsJnCAVwoIR2zyZTK4OZagkjlLjhO
 t6RPqBPMZwZNkw4AAT33QRESXlH7k8EoaaA5TF7pP0UWX9eOVE5i1IQRb5p9NJvXaDiM
 S2DmmE2xYAqCv8UZ//tvOwCSGNIsTjCsCGc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2w4rx34u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 13:11:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 13:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msq4OX2+P6ZVrzzB7vnNRAMwLG3QdqzaOXxcyEJC/cH+H9uacOnD1cf1/THWFVH7xxgGrtBMGqJSnTWN6BW4+Z1QSRnzdjQ+3iFajlNwu10RrCFV5oQ17oREz1B9+Gjbv8MJGG5Lp6qt/uN07rVhzqShkgu8PZajNpuwrqQaDV1C0PtLVIgoEBIpRHCOdk+Txtcj9p/JTeo1Wtp8ZRnX/1116Gb8fndYu6YhCGfXpUN1+KuBSufEO0fsOmmVhdmLr9QVhhnq2VVvw8EqnWD+c9uZp6DLd8D31frzewVjFREYD/iyToGNpycB7w8h9bfXRtHiSvKkdkqBdmGsT90WpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A90SG/L/tv8ncKltVgBHttXpKjZZiePgoiQGYap0ElA=;
 b=SOq/Frbz3rr76y8rIo54XW5Ix5a4DSuLnU4KKPwt/7fbhuliPQJHX3Noz26i/L8PYJ94FWZX+ZYDo+aWRjE9OeK+QFkfCKisnpFrPqBIrzf+uIJ3LzrdfoaMOBGP3Zwz+N7X/yCiIQfx2156N9x42zzWQ7m1JbV6vua+uAWdPZb8yQ7XmvpQzyfIF+3nD9rNZK9BrVbYWvzK72o6nc3HfbCHiEnMgbqY2qznC6WgQ7269Duk3h/9DWjPBbfwpzZSPnPgtiLjl0x5IOGfwtjGWq6XUPrMT5j/amnLHP8BdDlSFKaSBU+xo02M+hiBB8paSz0bJNXMfZ8w8Te9QOS8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 20:11:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 20:11:15 +0000
Message-ID: <7511b8fd-c5b6-96b3-8b1d-e7eeeb0b2c33@fb.com>
Date:   Tue, 2 Nov 2021 13:11:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211102084856.483534-1-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211102084856.483534-1-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:2e35) by MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 20:11:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787762dd-2a01-4f44-dd91-08d99e3cec69
X-MS-TrafficTypeDiagnostic: SA0PR15MB3967:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3967793BCA4BAD3A63F8E3ACD38B9@SA0PR15MB3967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJsfbHHTyUEAXZrJnpzXyowFy67qhXGXO/hAva5LgfLWXfpK53aHkMhm8CuPRVIDf8zwSvPXEeLnJHupoB91RQtCC1wD74R7dK/gCuEbQfx9wJCfssFj9eFoL+FrBJ0Eh5+YM+d+W6TSq+4qCUELH4cXD5ppL8DA9a7xgNvz8HFPb5P56UwzgmbNU+KNqZCZz6V59Lz4vuJt1AWDe7O8dEOBlqXHAt1/rBF9w7+WOtJDK72hi63wC+HM6xeqm+6qQDQXNHF81Ja/wKzvdZIaGkIumaz3dkzLIEQV1AHi/m977tPUTvRIxVpfwYjVXrAjngk8/VSlFFFTd+VbiaX5bC7Po7Qax90vsAM2YDXay25QiD73Mg4M4ohc5cP2rTJZ54LZCrv5h0p+py6NBjpQ2mtCF/K4j9aFvuL4+91faCpkY1qol6zEonPq8Ums0ZPJE421R+GK7QzA8rgBBS0jNF/hvQycOZwYSK9jQSV652zNXcXRM6tMw0dqGyefv9rL7K5Bm/fBcbHcbb74EjBK4GbsD0n0Vf8m4d6yLs/GRlYL+akjDeU1C5V9GtaF/XcfIWjN2qQtJHBsVt2O4dpotx+dMvHTOF1O1gfU9ne/AVLSF6eWvBf9lRonDi5AGRCwUjDFXIiiU/5n074pevAUUFrbV7dsN3UpK3H6VYHKLDdNRpJ3vIVIb8qLBQb9B/6BoUf1a0KhO+SexyQhzUQsBXNh60LOdzFCLvipZ8TcjfnPJiy859FqTPJQ1thS4mlzg5xtcuT8rJsYPhMbST4ehA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(66946007)(66556008)(36756003)(38100700002)(8936002)(66476007)(7416002)(53546011)(31696002)(2616005)(83380400001)(6486002)(52116002)(6666004)(4326008)(2906002)(186003)(31686004)(508600001)(316002)(921005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJZc3VOVmJnTDM3L01LMm9TVlQwdW5CWkd3SDJZZFFFclo1cHB1dkU0ZXhM?=
 =?utf-8?B?dlFxeTlNZlp3YldNUkN0Q3NUbS8yRjV2QmpxRmtIMHdlL3NaZFRxR3ZoNHdu?=
 =?utf-8?B?NUZRNDViRURiZFE2VHpZZ3pzelUvYWZiZWZkR1NUd2dDK0haekp5bktFdW82?=
 =?utf-8?B?R21xVm9BUXNCdWtQaTdmelNiWENsTnpSV1UvTi9sUUZ2Ukt3ZDRPTEpxOUtJ?=
 =?utf-8?B?STRwRzhjclliM01Ia0lrNS8vb2UwWTVyVUhoS1R0ZGFkelNkRWhqZzRJUXRl?=
 =?utf-8?B?R2pPTmwwT0piN0ZZRCtLWDR0R0ZjRElyakg3WjBycE5CNmsrZGpBdnRaZUxL?=
 =?utf-8?B?OVhqVVRJdml1UlNnL05wUEFiTXc2SXQwTFBOdGk5NTIvOHJMMnVyNHVONmsr?=
 =?utf-8?B?QmlNVUdMK05sQytZQkhKTHNQcEJtWEI3N1FLNU9UOGp1SDBFWGVjSkJqaTcz?=
 =?utf-8?B?d3dvS0hWeURyaGl5emdsVGQyUHBNdGJHdTdSWFZPSU5PaytGdU8wbkFIcDh1?=
 =?utf-8?B?cHZqSlVBenZqMUVHUGs5eDBCekR5UmR3cjQ5S0tQTGhKeGxJVENzNkpkT2Vi?=
 =?utf-8?B?ZlZaNmRRWTN1WXZ3dHNDNGFUSTlLYlJoL2NDSDNNa1VLOWlqdUtTTXB3Yytl?=
 =?utf-8?B?bEpsdkZDQmpZZGsxY3R0M1BwSkZyMjE1YnNiT1M3Z1U5UmZ0REc0WHBaLzd1?=
 =?utf-8?B?VS9MdzhSNXpoSm4rK0RqK1hCb2YvRWxtcU5aS1lVWCs1SE1vM3MvN0tyL1Ji?=
 =?utf-8?B?VFVKbDNzdVlMbVl1cm9LTkEzR2lPMDlCWGVNSFc5dW5sOHBmdkUzNTBDVmJI?=
 =?utf-8?B?RFFzUXRkbmVmbHR1MHpIckR1ZHFDRjVIMUFVYTBLQW13eHpxaWVCV3lGb3pZ?=
 =?utf-8?B?M2ZkUFdxOVUzSEFZNkorT3FleFZWTUptcU9JRTltOThLSWFEY2lpdXZlS2hF?=
 =?utf-8?B?THFpUjBQcnUwM3Y3SFNUUHI1cTRNUjJuVm5aaEJxMml3RmYrb25ZbzJ1OTRr?=
 =?utf-8?B?eHc4YTE5YVdZV0c2VDNYdEloays2T3NmSDdvbVhZeUNOUmR1dXI2cTNDTzRP?=
 =?utf-8?B?WEUvSGZDZjU5R2wydVJOVW1nL0JsRWNFVElPZHliYmJVWEcvcEVwTFFYbHdL?=
 =?utf-8?B?ZzI0UWZRbWUzVjQyRWRCY0RkcUg3SGRZZERkYTl2bE4xR3YrNWRhaUlFT1kz?=
 =?utf-8?B?OFFZZnFIekpYNld5WWdDUXJNanZDTUFGdExTeUY0S0pyZytGdS81ZHBnNEJo?=
 =?utf-8?B?QTZtR25IbEcxaGt3TTJQdUc3RDFSL1p0MFNhYVJ2UmlEMkpzR2xXczlQM09i?=
 =?utf-8?B?MTVERlhBNnlTajUvWCtZM0pEaTF5blQ2UHlYS1RYMnlzZXhwNlc0TzRRRWVE?=
 =?utf-8?B?K0JUQ0ZBQzE4Y3BGVnFVbVZReEJLVjJ5bFJmTTljY2gvdytnV0JXZlFxOGJV?=
 =?utf-8?B?REF3RWowWldvRy84cEt3Y3g3MzlHQVlUK2ZCTERla3pucVB0SjI1NG1OeXVJ?=
 =?utf-8?B?VHI4eGVJbFRRbDBXYXVMVVRJTzdrTVdPcWRyU3pITWZoTEt6eldMSjhZMHJE?=
 =?utf-8?B?amFHYkRtVC9USE9JWU1BOVBIb3UwZmM4TitJYmttMjhUMFNON0dkVWQ2Qklp?=
 =?utf-8?B?U004cFphcXIwVTlJM1U5ZWl6NENUSEhhNHo0Nnd1eElqWG52RSthZVdQSWRS?=
 =?utf-8?B?TmRjY0ZMZTZkU3UyelpWdDBUS09hMDNlNWRoYWRrYmpqV25LbXNMT2pNbyt2?=
 =?utf-8?B?ZGlaeFpJaVVINklHcnhBckEzRUFGdnlkbEJTWTBPU2N3VlNTNmJhdDhUbW9C?=
 =?utf-8?B?anQrWUtKd1ZqRk5BeXdQeWh2ZGwvRjZ5SUpwazVCUVY5TlEzSDNmcStWdUNp?=
 =?utf-8?B?enJmR2hPVXV2VUVOa3ZXZUlySklQTktuemdRZGZHZHhPd1ZjSE9SbFBCaWVj?=
 =?utf-8?B?OElSRnpBNUUwZis5RXZCUjJ0L0R2K05aSHBjS3pyMUhLNlF5bStGMTY3bWZs?=
 =?utf-8?B?TUJFOXZOY09tMnZXSTBieVpQZzB2enJqMjJ6ZDBoVmdrSW9iZ2dlMERhVkg0?=
 =?utf-8?B?aUdHQ3phWEd2V3I1Ym9VUGRlTmJtSnh2dmNMcjdnWUFZUWN5TmFxSGVSRy9C?=
 =?utf-8?B?ZHhYaTQ0azBtMnZKV0ZCM3g2Z0VFOUdwOVVxajR2WEd6WkM5SjhGQXJwT0xa?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 787762dd-2a01-4f44-dd91-08d99e3cec69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 20:11:15.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ5CjYoGAVgaWMv8KtfLCH37LoCd6uCRK6+LCJeOzS9vEPmrKJwZEiZZ9OuOUpUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rVdMw36OZhszwIwLcNmeFdRD7hvSbdpp
X-Proofpoint-GUID: rVdMw36OZhszwIwLcNmeFdRD7hvSbdpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 1:48 AM, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
> 
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
>   include/linux/bpf.h  |  9 +++++
>   kernel/bpf/syscall.c |  5 +++
>   net/core/sock_map.c  | 88 ++++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 95 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d604c8251d88..594ca91992db 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>   int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
>   int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
>   int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> +int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +			   union bpf_attr __user *uattr);

All previous functions are with prefix "sock_map". Why you choose
a different prefix "sockmap"?

> +
>   void sock_map_unhash(struct sock *sk);
>   void sock_map_close(struct sock *sk, long timeout);
>   #else
> @@ -2014,6 +2017,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +					 union bpf_attr __user *uattr)
> +{
> +	return -EINVAL;
> +}
>   #endif /* CONFIG_BPF_SYSCALL */
>   #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4e50c0bfdb7d..17faeff8f85f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
>   	case BPF_FLOW_DISSECTOR:
>   	case BPF_SK_LOOKUP:
>   		return netns_bpf_prog_query(attr, uattr);
> +	case BPF_SK_SKB_STREAM_PARSER:
> +	case BPF_SK_SKB_STREAM_VERDICT:
> +	case BPF_SK_MSG_VERDICT:
> +	case BPF_SK_SKB_VERDICT:
> +		return sockmap_bpf_prog_query(attr, uattr);
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index e252b8ec2b85..ca65ed0004d3 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1412,38 +1412,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>   	return NULL;
>   }
>   
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -				struct bpf_prog *old, u32 which)
> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog **pprog[],

Can we just change "**pprog[]" to "***pprog"? In the code, you really 
just pass the address of the decl "struct bpf_prog **pprog;" to the 
function.

> +				u32 which)

Some format issue here?

>   {
>   	struct sk_psock_progs *progs = sock_map_progs(map);
> -	struct bpf_prog **pprog;
>   
>   	if (!progs)
>   		return -EOPNOTSUPP;
>   
>   	switch (which) {
>   	case BPF_SK_MSG_VERDICT:
> -		pprog = &progs->msg_parser;
> +		*pprog = &progs->msg_parser;
>   		break;
>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>   	case BPF_SK_SKB_STREAM_PARSER:
> -		pprog = &progs->stream_parser;
> +		*pprog = &progs->stream_parser;
>   		break;
>   #endif
>   	case BPF_SK_SKB_STREAM_VERDICT:
>   		if (progs->skb_verdict)
>   			return -EBUSY;
> -		pprog = &progs->stream_verdict;
> +		*pprog = &progs->stream_verdict;
>   		break;
>   	case BPF_SK_SKB_VERDICT:
>   		if (progs->stream_verdict)
>   			return -EBUSY;
> -		pprog = &progs->skb_verdict;
> +		*pprog = &progs->skb_verdict;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
>   
> +	return 0;
> +}
> +
> +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> +				struct bpf_prog *old, u32 which)

Some format issue here?

> +{
> +	struct bpf_prog **pprog;
> +	int ret;
> +
> +	ret = sock_map_prog_lookup(map, &pprog, which);
> +	if (ret)
> +		return ret;
> +
>   	if (old)
>   		return psock_replace_prog(pprog, prog, old);
>   
> @@ -1451,6 +1463,68 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>   	return 0;
>   }
>   
> +int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +			   union bpf_attr __user *uattr)

Format issue here?

> +{
> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);

Typically we use u32 in the kernel code. But I know there are __u32 
usage as well, esp. with __user attributes. I put a comment here just
in case that somebody else has a different opinion.

> +	u32 prog_cnt = 0, flags = 0;
> +	u32 ufd = attr->target_fd;

You can merge the above u32 together.

> +	struct bpf_prog **pprog;
> +	struct bpf_prog *prog;
> +	struct bpf_map *map;
> +	struct fd f;
> +	int ret;
> +	u32 id = 0;

to maintain reverse christmas tree?

> +
> +	if (attr->query.query_flags)
> +		return -EINVAL;
> +
> +	f = fdget(ufd);
> +	map = __bpf_map_get(f);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	rcu_read_lock();
> +
> +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> +	if (ret)
> +		goto end;
> +
> +	prog = *pprog;
> +	prog_cnt = (!prog) ? 0 : 1;
> +
> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +		goto end;
> +
> +	prog = bpf_prog_inc_not_zero(prog);

Could you explain why we need bpf_prog_inc_not_zero here?
We are inside rcu_read_lock/unlock region. We got a program
from *pprog. If this program is not NULL, this program should
not disappear since we are in rcu read lock region, right?
Maybe I missed something, it would be good you can explain
the scenario you try to pretect here.

> +	if (IS_ERR(prog)) {
> +		ret = PTR_ERR(prog);
> +		goto end;
> +	}
> +	id = prog->aux->id;
> +	bpf_prog_put(prog);
> +
> +end:
> +	rcu_read_unlock();
> +
> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +	if (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
> +		ret = -EFAULT;
> +		goto err;
> +	}

You can do

	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
		ret = -EFAULT;

to make code a little bit concise.

> +
> +err:
> +	fdput(f);
> +	return ret;
> +}
> +
>   static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
>   {
>   	switch (link->map->map_type) {
> 
