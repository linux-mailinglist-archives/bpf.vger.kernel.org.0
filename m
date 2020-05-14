Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB51D34CC
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgENPRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 11:17:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1628 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgENPRD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 11:17:03 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EFFQcd011345;
        Thu, 14 May 2020 08:16:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uldeb5KNpdLUDiW5lW4UO0UnzyhqeB+zT0vEauwpdr0=;
 b=GJZJcvWcECj/qzyp9WaOgJ53ll29qCdUjbqFZBK0PsvcVTUoNRK9/qjR3e/SlPyYoLbG
 xz68m9Aaw63DjbHgoVQAHcPitFkSUB/BB0E1pjI1RbH7AasgPsYO+5hVh9GV67NB0eAR
 LMmIMn73LktfpzGPoTRdbgW5jJrbT3l392I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3110kjtcw7-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 08:16:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 08:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFffZe0v7uHAjnujhTTELCOs/DfknypEV06EsDsFAfkFqjm7xQLQgeUsmpA/QcxRNHSUDYM1dxvNpHZeMbOj24dtrTfz9/msDYYc/bkte8OeF3Jd/kobS2h9W7bRPxhT6JeUbE5e55QoOreMHq9B8iVta6GQf3ktGzxU1cKhOHDDdFLrHVGHLN+p8XOzvwvhhuVhzT6iBqDgygKPFJ2IVM4k3ARuhcIdoS6/85hHgwddCI0rwVLKorgxiTsEW1w2D32VzHONE/eXtxXz6amdGxxFGzcEqUpi6OkbPTtwAZM94OLf8ACzVhl2yuH79UZWqqeLk4o+No/QWiA+GsyNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uldeb5KNpdLUDiW5lW4UO0UnzyhqeB+zT0vEauwpdr0=;
 b=fVBzX6pibLjaLhO/fngY7KMIeg721NeIpnH6qC73ZkVupyurs0DDlNzNAjwZFR4fOxHlmWZ+2WSC+/7MgCQaGXaJoniHEXHO4BWFS5/Yi2mocE/pkV/U+PPQuoA/6R9NRjBwGk/vzDTMdFDcm594s8OSHA735YpbqfwvtxUJxg3MyXXJuSEBcCBxxgOgag14pwE0jBTdfatcc1s2xPfsHc3O0cyy5tjEV9WxQiS2Rw2qrOjGHfaEO47UImclIiLcDwDAcftyAk8wENy9Wj7Z2o0gRcwMM+RJrZSWGJvhao7fTLzq684otIJ+Yhkh9rW46RDrx1XhI6eiS6XTFv3XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uldeb5KNpdLUDiW5lW4UO0UnzyhqeB+zT0vEauwpdr0=;
 b=lBsGAGSF0ry22DiGG1WrMphvHTXo9eGd7u2FcIjcnajuuTbBDNefdR1MCyA6u4Jth1pQ9lyyrZpXIkWNHz+xIWLsXHalIonoVKZnnSrRcfiP55eGxBnjEVj4a038eY0N9KPEduxJiMRXjRZ3vBq/+VaTPZDGw0UZVP0fD5eMaFA=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2727.namprd15.prod.outlook.com (2603:10b6:a03:15b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 15:16:46 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 15:16:46 +0000
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Introduce
 bpf_sk_{,ancestor_}cgroup_id helpers
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
Date:   Thu, 14 May 2020 08:16:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:3bff) by BYAPR08CA0045.namprd08.prod.outlook.com (2603:10b6:a03:117::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 15:16:45 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3feeafb6-4953-4fa1-9101-08d7f819d124
X-MS-TrafficTypeDiagnostic: BYAPR15MB2727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2727A1B8062A9E33CECCCEA8D3BC0@BYAPR15MB2727.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sgIVzhGQCjM8Uytpf1aCje9h/SxIvv4NnAUKSD0AIBAzyZnzpy/IxR/VhrL8F5q+2Pt7hnS/L8EApxrW2VfYJSUIytTNU4Qr9L7/Pc114WRpugutA4Uadq8xDkKtNbwB+DDaNknYO6/kTbessDbame0LPHlyqJtxuOtkrXPh5OWj05otCp/C4DUPnGaEHWP6GpHwm3t8E5OcALs0vqjEZpAPf4eV+PKz9kq7ni3aXPsyJoLdl+B42mBBt7yzC6G0Bd+0u+4VrW6Z7nvepef9kT8uOBtdFMwDjhG8Zx3RNaPUAxzodw05lQuPDx7b2c4NorEwOd4cUfleIpKlD4H/nyVq1pb13jkklkwpFvLGCtCj/NQ8WORXZBXO583TzWqmd198AEyygVCzHMxP0XCcXNyRFpI5jj710rddJiYlOHYnftSYQRrp2Ax6Wb07HLT/93gYQHKOkGrh6i/XPTFrwSy971eiB1hTeOnDzT1vlkevQ8dH0z7r0cNxUOK8FVU2mKK3ugXZ/CKsSaHXGG2yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(86362001)(66946007)(66556008)(4326008)(2616005)(31696002)(31686004)(66476007)(6486002)(478600001)(52116002)(8676002)(6512007)(2906002)(316002)(6506007)(53546011)(16526019)(5660300002)(36756003)(8936002)(186003)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mXGDxwSHVqfLfohA5o6yV3pafPWfXbs1Zdh9D1MZ07l5AnWbO8Pxhbp+McrelDQRy2jGApf9gpcUCVJFAaK6/j/Pn5r6dbv14ZuZk23ZYmGxI7i94gB8D9GHR8MWLAdLh8P74neTmFWMdreTL1HKDTon7g6drsCJVLZKuvnLrSwRakUu/0QXDZaGgGfGiPGJ2pKKqMjiHXARUVMS6FEirBOrA+hTdBnfGUyiMGYdrDZZ/qmXMdeug065l9Fsxrua5m26v4cRPZeALGQLtnnSQdhA5JK0dbFBqk56B3Y7zkgdWYUn5Bi5G4SmP6fdgTJiNCm3r1cAUHR/yMGaiGSctykrJVuXrl8CttrCntXF3TEgp2sZiKcOLesci25tiKfUaeexJMqetN1+ToTebZxCdYzVQyZ9mHTj/6ypk9qLlvRBUk1LrJtix+DGnV8Wvi8RFpfyun0H+U2Kos17njOEN2u/Gni2PMn1wyYruSbe+ouOSgf4jCzoAm2arpYdSw+SRu8eCbQchpZ33tXpV8MR4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feeafb6-4953-4fa1-9101-08d7f819d124
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:16:46.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMU7q+k0OtbngO+/UDuc7VQwbGPJ0BrMu2/WG1yX6BqERBytl1P13ShtSs0NV839
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 cotscore=-2147483648
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> With having ability to lookup sockets in cgroup skb programs it becomes
> useful to access cgroup id of retrieved sockets so that policies can be
> implemented based on origin cgroup of such socket.
> 
> For example, a container running in a cgroup can have cgroup skb ingress
> program that can lookup peer socket that is sending packets to a process
> inside the container and decide whether those packets should be allowed
> or denied based on cgroup id of the peer.
> 
> More specifically such ingress program can implement intra-host policy
> "allow incoming packets only from this same container and not from any
> other container on same host" w/o relying on source IP addresses since
> quite often it can be the case that containers share same IP address on
> the host.
> 
> Introduce two new helpers for this use-case: bpf_sk_cgroup_id() and
> bpf_sk_ancestor_cgroup_id().
> 
> These helpers are similar to existing bpf_skb_{,ancestor_}cgroup_id
> helpers with the only difference that sk is used to get cgroup id
> instead of skb, and share code with them.
> 
> See documentation in UAPI for more details.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Ack with one nit below.
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   include/uapi/linux/bpf.h       | 35 +++++++++++++++++++-
>   net/core/filter.c              | 60 +++++++++++++++++++++++++++++-----
>   tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++++-
>   3 files changed, 119 insertions(+), 11 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bfb31c1be219..e3cbc2790cdf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3121,6 +3121,37 @@ union bpf_attr {
>    * 		0 on success, or a negative error in case of failure:
>    *
>    *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
> + *
> + * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
> + *	Description
> + *		Return the cgroup v2 id of the socket *sk*.
> + *
> + *		*sk* must be a non-**NULL** pointer that was returned from
> + *		**bpf_sk_lookup_xxx**\ (). The format of returned id is same

It should also include bpf_skc_lookup_tcp(), right?

> + *		as in **bpf_skb_cgroup_id**\ ().
> + *
> + *		This helper is available only if the kernel was compiled with
> + *		the **CONFIG_SOCK_CGROUP_DATA** configuration option.
> + *	Return
> + *		The id is returned or 0 in case the id could not be retrieved.
> + *
> + * u64 bpf_sk_ancestor_cgroup_id(struct bpf_sock *sk, int ancestor_level)
> + *	Description
> + *		Return id of cgroup v2 that is ancestor of cgroup associated
> + *		with the *sk* at the *ancestor_level*.  The root cgroup is at
> + *		*ancestor_level* zero and each step down the hierarchy
> + *		increments the level. If *ancestor_level* == level of cgroup
> + *		associated with *sk*, then return value will be same as that
> + *		of **bpf_sk_cgroup_id**\ ().
> + *
> + *		The helper is useful to implement policies based on cgroups
> + *		that are upper in hierarchy than immediate cgroup associated
> + *		with *sk*.
> + *
> + *		The format of returned id and helper limitations are same as in
> + *		**bpf_sk_cgroup_id**\ ().
> + *	Return
> + *		The id is returned or 0 in case the id could not be retrieved.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3250,7 +3281,9 @@ union bpf_attr {
>   	FN(sk_assign),			\
>   	FN(ktime_get_boot_ns),		\
>   	FN(seq_printf),			\
> -	FN(seq_write),
> +	FN(seq_write),			\
> +	FN(sk_cgroup_id),		\
> +	FN(sk_ancestor_cgroup_id),
>   
[...]
