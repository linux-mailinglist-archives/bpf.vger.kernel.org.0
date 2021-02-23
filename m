Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52133230E5
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhBWSky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 13:40:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1386 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232986AbhBWSkx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 13:40:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NIQRAl004482;
        Tue, 23 Feb 2021 10:39:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3AyT9/puSfi5VAw+phjGdI7qowS6z4btmAn8KS+tYjs=;
 b=DGgky8fsztnL7yNtKhp/MsMxtnZeGhCcttUSG0aC0iLR8RfInzuvjXaen2PdMtIR9y8x
 9bgVuJGF3GPZ+TeczBceQTedtZHJ5DB5us/bn6wyVESR2zQVYvtcp3W6dNvdRaXcTgh1
 c8oHkba8Ry8YQFCVQdHpbvruGIMgwIHjZ1U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ujy7mw7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 10:39:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:39:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dES8a76TiOefZDKsSWcZuQET/kE0CyYy9zPfwFIqUVQJblfjYRKr+9+SG3hO1m03xJV9+MMoZtUYXu4zBFCiq3poRYz+my58vNK45sHbVMGoYX+TQemuoxT7Qv4gaU+aMuBgr3b8kai8KQIoR/0IN056YQmZ66EFyuxmoBMdvzGxLHzRp0t1TLPaVPCTCEfV6JHTLwAOvWdWkOBP1d1ADrcK69Fn1tr2zZ1AEHCRxf+CtEKOLqnyEuTiCXGIQqTxFsBvJwQjgWYm7CLBUmfu4gHqpvzGdxsUT0qilx+VIyvQUAcg272evecB7C7bSdsFKkmWy1+2R4wErZNKCnFePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AyT9/puSfi5VAw+phjGdI7qowS6z4btmAn8KS+tYjs=;
 b=n6Rex0SW0l3kTHmAfQ6d2yRa9gdeWJEOFMtFHb8GKgKP0O5cUiiag5NMhzC3HPP8T3NghiarAPB0BPcuOM1NrbkBi6cVnExeI2NVufUle75j4ByZHjRXVjrvCVHSMvBCTQFN809Qp8tj9pAVEyn2kyOseJxz1mZJ/Nd3C+sDGwlxHrJHww2tPRaODqqqM/R8Xjn+pVhBrDuD0NaZsG4I6kdB+FQYfYvn40n7TIoZbiIaN+rFRwD7ve28Bv/DytEEBbVxhBvfVT5c3TugAWn7XaMBhhUNSgi4kdyII/wAiH2k0WoK17oWXqdT90qaYz1qYP1coeFTzGMRqRi+1RWjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2205.namprd15.prod.outlook.com (2603:10b6:805:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 18:39:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:39:54 +0000
Subject: Re: [PATCH bpf-next v2 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181807.3190187-1-yhs@fb.com>
 <20210222205912.hucaxodzk7csrdyj@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <083e0c5c-71c5-a735-63e7-4c5b8b1e9149@fb.com>
Date:   Tue, 23 Feb 2021 10:39:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210222205912.hucaxodzk7csrdyj@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: MWHPR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:301:2::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by MWHPR12CA0027.namprd12.prod.outlook.com (2603:10b6:301:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1abbac8-860f-4113-7d48-08d8d82a68b9
X-MS-TrafficTypeDiagnostic: SN6PR15MB2205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2205B7688E5BB4BDEF693B8AD3809@SN6PR15MB2205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Dg1u3SlWjaqpAk8Bpinhdzrw3wNn4f0ufbfv6UN4oNoQ3RO6NyTMreCYXiyNbm0YzoQGt1nfvd+KBCT5ZuZ/P/Ui8ywi9cRRDMfcOObUMiNlJx/d+5LDtKfj9JMf/H+kVmablsTlTj8YteMZe8jJ/RiDU/xVgDBFRmpAVYZJqDFBkGBEI/LhcrvOmF5S7ny6aYyMfOv+jkx3ZyLg6ux+/e4UorEDZboVjdf4LY2PVqs9UxrRyD9X8Jdd6CM5Tn2wHUGYLJkmcWZ14y6FNkKpmo4FHY5XQ8K2GFZumgmfalw1E9QdgBCKSguXN40pA/GmLzkYgLDZF2xKvR6Qb0t5l2w8P7NTyB7mEFrpjiJQ+bim4PaD+OJRkkrirC8xkMi7HW61LpyXRjqrtzYGfNwO2WGKkP1Q/ZZJjiR+yaLF/k8QWIA9mg87a5arvrwX4J7mOCS72yTf4tQYZ/jXr75/nrA5j46TqGOvNnFCiRsZ7y12/3FAUrds36PueZP5jt/On/FN9D8ye5hzakZ1H0F5AZbpDxSm9ZUYIcUfUsgz/vC87kAmrShPKlMysHPB+IKC3R6mj/8erHqu1j0nYJSdHkSIlIllv3rnwZ4ntxygwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(6666004)(54906003)(53546011)(16526019)(6486002)(52116002)(5660300002)(66476007)(4326008)(478600001)(36756003)(186003)(31686004)(316002)(66946007)(31696002)(2616005)(6916009)(8936002)(86362001)(66556008)(83380400001)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 73dt2oA5smCZs4ZVR3V3bj4yAB2C+kO92sNWxw7ugrrCiTP0/xI2WOEAaTGz/fwuQs4VTePZd4BKfGd38FaiozrLWzBa87HresyQWD55EXIsio9WmcpwOHihKmTVPce8kKJlGnpogn2BMbHPz0Ovesu1q6G4hF4/+pGlz04uuwD21ppoDUUWuQ2f+Cdg0bCS93ZesZ9WhKPVCYkkJZq9rdw1WEEhY1xoXeq8/2uyT8oS3fy+jxm/5rDqBZbKb64XvHWjKuQAM1K1idC+8TFpe+h+GwTBS8t480Uy1jLt5OI4/XweoyGcgNAoQ9Dxq0Ay4PYNB3gskwWiLJdBWtMZsbgDznJ9DCkzBNPQv2eys4LY1ZeKMeFfQ46BdTHQ1LjhtAgxIie8lHm1vajf0KWuxvV6kzwZ2L2nxjXgO5b185b2Y4X/A314hWWzL66bsrSUmFHB3lSOQFbt6MS85J95D0QVEvyhZdOHNgiZrf5EOdiUUxKiamv+pXhLfrsj9JTYYKGvQcGQvHBV45rmdW1AlxKhti2SElhp5rxDsXMOQunlMzFXhoVMvPU6vYMCUo3k4aXWci+ElHJ92ZENlbgAi7/9EnloYtqO4/ihNdzr6Oa0Ctj2CRaWh6zIL4hy50Bc3uvOZX6GQYXaFjYPDN+LWaMReVgF2rIK8gFD0v/Nen4BqfJDSFVW7qARLyW1qMs5TXvyfnhn4RcwMkbqXxrkMtzPieAbdkfH33j26ma10QPw2z2kij449Zsx2JO7ihafaSpVXYN26YjGfhY7J4r/8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1abbac8-860f-4113-7d48-08d8d82a68b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:39:54.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+IjD2I0/6Vk/ML3kjK6gimdxsHb1QqFeZQEdq6wkBXx18D/w8BJEmcBja9PuaiF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/22/21 12:59 PM, Alexei Starovoitov wrote:
> On Wed, Feb 17, 2021 at 10:18:07AM -0800, Yonghong Song wrote:
>> @@ -5893,6 +6004,14 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
>>   		else
>>   			*ptr_limit = -off;
>>   		return 0;
>> +	case PTR_TO_MAP_KEY:
>> +		if (mask_to_left) {
>> +			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>> +		} else {
>> +			off = ptr_reg->smin_value + ptr_reg->off;
>> +			*ptr_limit = ptr_reg->map_ptr->key_size - off;
>> +		}
>> +		return 0;
> 
> This part cannot be exercised because for_each will require cap_bpf.
> Eventually we might relax this requirement and above code will be necessary.
> Could you manually test it that it's working as expected by forcing
> sanitize_ptr_alu() to act on it?

I did some manual test and hacking the verifier to make this code 
executed and it looks fine and verifier succeeded.

But since this code won't execute with current implementation
with bpf_capable(). It probably makes sense to remove this code
for now and will add it back later once bpf_pseudo_func is permitted for
unprivileged user.

> 
>>   	case PTR_TO_MAP_VALUE:
>>   		if (mask_to_left) {
>>   			*ptr_limit = ptr_reg->umax_value + ptr_reg->off;
>> @@ -6094,6 +6213,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>>   		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
>>   			dst, reg_type_str[ptr_reg->type]);
>>   		return -EACCES;
>> +	case PTR_TO_MAP_KEY:
>>   	case PTR_TO_MAP_VALUE:
>>   		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
>>   			verbose(env, "R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
>> @@ -8273,6 +8393,21 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   		return 0;
>>   	}
>>   
>> +	if (insn->src_reg == BPF_PSEUDO_FUNC) {
>> +		struct bpf_prog_aux *aux = env->prog->aux;
>> +		u32 subprogno = insn[1].imm;
>> +
>> +		if (aux->func_info &&
>> +		    aux->func_info_aux[subprogno].linkage != BTF_FUNC_STATIC) {
> 
> Could you change above to "!aux->func_info || aux..." ?
> That will force for_each to be available only when funcs are annotated.
> The subprogs without annotations were added only to be able to manually
> craft asm test cases for subprogs in test_verifier.
> The for_each selftests in patches 10 and 11 are strong enough.
> The asm test would not add any value.
> So I would like to avoid supporting something that has no real use.

Will do.
