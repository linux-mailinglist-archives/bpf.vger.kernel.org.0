Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064124C8108
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiCAC2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 21:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCAC2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 21:28:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D026274
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 18:28:06 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K71JF2BLSzbbvl;
        Tue,  1 Mar 2022 10:23:25 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 10:28:03 +0800
Message-ID: <fea6d061-f9cf-2869-fd20-24d9e6eae76f@huawei.com>
Date:   Tue, 1 Mar 2022 10:28:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH bpf-next v3 0/2] Fix btf dump error caused by declaration
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20220224120943.1169985-1-xukuohai@huawei.com>
 <CAEf4Bzaw3hDqrJ=sQVVjY-Gpjf90tWRpo-s2a_vFYTKWEe9qqw@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAEf4Bzaw3hDqrJ=sQVVjY-Gpjf90tWRpo-s2a_vFYTKWEe9qqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/3/1 9:31, Andrii Nakryiko wrote:
> On Thu, Feb 24, 2022 at 3:59 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> This series fixes a btf dump error caused by forward declaration.
>>
>> Currently if a declaration appears in the BTF before the definition,
>> the definition is dumped as a conflicting name, eg:
>>
>>      $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
>>      [81287] FWD 'unix_sock' fwd_kind=struct
>>      [89336] STRUCT 'unix_sock' size=1024 vlen=14
>>
>>      $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
>>      struct unix_sock;
>>      struct unix_sock___2 {      <--- conflict, the "___2" is unexpected
>>                      struct unix_sock___2 *unix_sk;
>>
>> This causes a "definition not found" compilation error if the dump output
>> is used as a header file.
>>
> 
> seems like I replied about test failures on v2 instead of v3 (there
> are test failures for v3, though), please check the link in that
> reply. But I wanted to also mention that it would be great to keep a
> succinct version log in the cover letter with what was changed or
> fixed between versions (see other submissions on the mailing list).
> 

Sorry for not describing the change log clearly, will add it in the v4.

