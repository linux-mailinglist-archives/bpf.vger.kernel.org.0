Return-Path: <bpf+bounces-4762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D272B74F107
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9931C1C20F59
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C119BA4;
	Tue, 11 Jul 2023 14:03:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9514AB5;
	Tue, 11 Jul 2023 14:03:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0114F127;
	Tue, 11 Jul 2023 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NCe20DJxaBTemI8S1kSVzZUvr73+rwHUToovZ2WdzP4=; b=ncCNbccrzrIFicDTnSEtOL7fbr
	0ML24MM0HScWxcxeOazUxPWt8cEcHtGsSa7ZlzjqQUKYy4BO+Hzq/DXzMWYImgzqIFrnzj/16VnkR
	zh2Zq9rmITbycVSSVkJFyJgTXbZ1qjS4XcnLdCBh7ERqjEgWw2ymzQFCiblvPnvHkP9q7S+h3/daW
	WZv/I8slbAPAGAj2wfO06Velvr7bN6FBcjSPF//Qm/vyOpogesSo+sOtc5di6dM6EvL8OdkpiMS7b
	s7GGAob+TbsDJ4sOvYWn9950l07qjb8R0nyT8+Wh4vGNdGh2H2nbJJXSErO45aGwJh6stdX88j/JK
	sRyqmCIQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJDxr-000OUm-Ch; Tue, 11 Jul 2023 16:03:39 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJDxq-000CVL-SD; Tue, 11 Jul 2023 16:03:38 +0200
Subject: Re: [PATCH bpf-next v4 3/8] libbpf: Add opts-based
 attach/detach/query API for tcx
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-4-daniel@iogearbox.net>
 <CAEf4BzaGbVe3ip_cDxV0u8bBUEVExdqHXOFBorHWZ0tpDBLLnw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dd7aaf1e-9abf-0b9c-bfba-ee3bc4cfa852@iogearbox.net>
Date: Tue, 11 Jul 2023 16:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaGbVe3ip_cDxV0u8bBUEVExdqHXOFBorHWZ0tpDBLLnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 6:00 AM, Andrii Nakryiko wrote:
> On Mon, Jul 10, 2023 at 1:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Extend libbpf attach opts and add a new detach opts API so this can be used
>> to add/remove fd-based tcx BPF programs. The old-style bpf_prog_detach() and
>> bpf_prog_detach2() APIs are refactored to reuse the new bpf_prog_detach_opts()
>> internally.
>>
>> The bpf_prog_query_opts() API got extended to be able to handle the new
>> link_ids, link_attach_flags and revision fields.
>>
>> For concrete usage examples, see the extensive selftests that have been
>> developed as part of this series.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   tools/lib/bpf/bpf.c      | 105 +++++++++++++++++++++++++--------------
>>   tools/lib/bpf/bpf.h      |  92 ++++++++++++++++++++++++++++------
>>   tools/lib/bpf/libbpf.c   |  12 +++--
>>   tools/lib/bpf/libbpf.map |   1 +
>>   4 files changed, 157 insertions(+), 53 deletions(-)
>>
> 
> Thanks for doc comments! Looks good, left a few nits with suggestions
> for simplifying code, but it's minor.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 3b0da19715e1..3dfc43b477c3 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -629,55 +629,87 @@ int bpf_prog_attach(int prog_fd, int target_fd, enum bpf_attach_type type,
>>          return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
>>   }
>>
>> -int bpf_prog_attach_opts(int prog_fd, int target_fd,
>> -                         enum bpf_attach_type type,
>> -                         const struct bpf_prog_attach_opts *opts)
>> +int bpf_prog_attach_opts(int prog_fd, int target,
>> +                        enum bpf_attach_type type,
>> +                        const struct bpf_prog_attach_opts *opts)
>>   {
>> -       const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
>> +       const size_t attr_sz = offsetofend(union bpf_attr, expected_revision);
>> +       __u32 relative_id, flags;
>>          union bpf_attr attr;
>> -       int ret;
>> +       int ret, relative;
>>
>>          if (!OPTS_VALID(opts, bpf_prog_attach_opts))
>>                  return libbpf_err(-EINVAL);
>>
>> +       relative_id = OPTS_GET(opts, relative_id, 0);
>> +       relative = OPTS_GET(opts, relative_fd, 0);
>> +       flags = OPTS_GET(opts, flags, 0);
>> +
>> +       /* validate we don't have unexpected combinations of non-zero fields */
>> +       if (relative > 0 && relative_id)
>> +               return libbpf_err(-EINVAL);
> 
> I left a comment in the next patch about this, I think it should be
> simple `if (relative_fd && relative_id) { /* bad */ }`. But see the
> next patch for why.
> 
>> +       if (relative_id) {
>> +               relative = relative_id;
>> +               flags |= BPF_F_ID;
>> +       }
> 
> it's a bit hard to follow as written (to me at least). How about a
> slight variation that has less in-place state update
> 
> 
> int relative_fd, relative_id;
> 
> relative_fd = OPTS_GET(opts, relative_fd, 0);
> relative_id = OPTS_GET(opts, relative_id, 0);
> 
> /* only one of fd or id can be specified */
> if (relative_fd && relative_id > 0)
>      return libbpf_err(-EINVAL);
> 
> ... then see further below
> 
>> +
>>          memset(&attr, 0, attr_sz);
>> -       attr.target_fd     = target_fd;
>> -       attr.attach_bpf_fd = prog_fd;
>> -       attr.attach_type   = type;
>> -       attr.attach_flags  = OPTS_GET(opts, flags, 0);
>> -       attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
>> +       attr.target_fd          = target;
>> +       attr.attach_bpf_fd      = prog_fd;
>> +       attr.attach_type        = type;
>> +       attr.attach_flags       = flags;
>> +       attr.relative_fd        = relative;
> 
> instead of two lines above, have simple if/else
> 
> if (relative_if) {
>      attr.relative_id = relative_id;
>      attr.attach_flags = flags | BPF_F_ID;
> } else {
>      attr.relative_fd = relative_fd;
>      attr.attach_flags = flags;
> }
> 
> This combined with the piece above seems very straightforward in terms
> of what is checked and what's passed into attr. WDYT?

All sgtm, I've implemented the suggestions locally for v5.

>> +       attr.replace_bpf_fd     = OPTS_GET(opts, replace_fd, 0);
>> +       attr.expected_revision  = OPTS_GET(opts, expected_revision, 0);
>>
>>          ret = sys_bpf(BPF_PROG_ATTACH, &attr, attr_sz);
>>          return libbpf_err_errno(ret);
>>   }
>>
>> -int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
>> +int bpf_prog_detach_opts(int prog_fd, int target,
>> +                        enum bpf_attach_type type,
>> +                        const struct bpf_prog_detach_opts *opts)
>>   {
>> -       const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
>> +       const size_t attr_sz = offsetofend(union bpf_attr, expected_revision);
>> +       __u32 relative_id, flags;
>>          union bpf_attr attr;
>> -       int ret;
>> +       int ret, relative;
>> +
>> +       if (!OPTS_VALID(opts, bpf_prog_detach_opts))
>> +               return libbpf_err(-EINVAL);
>> +
>> +       relative_id = OPTS_GET(opts, relative_id, 0);
>> +       relative = OPTS_GET(opts, relative_fd, 0);
>> +       flags = OPTS_GET(opts, flags, 0);
>> +
>> +       /* validate we don't have unexpected combinations of non-zero fields */
>> +       if (relative > 0 && relative_id)
>> +               return libbpf_err(-EINVAL);
>> +       if (relative_id) {
>> +               relative = relative_id;
>> +               flags |= BPF_F_ID;
>> +       }
> 
> see above, I think the same data flow simplification can be done
> 
>>
>>          memset(&attr, 0, attr_sz);
>> -       attr.target_fd   = target_fd;
>> -       attr.attach_type = type;
>> +       attr.target_fd          = target;
>> +       attr.attach_bpf_fd      = prog_fd;
>> +       attr.attach_type        = type;
>> +       attr.attach_flags       = flags;
>> +       attr.relative_fd        = relative;
>> +       attr.expected_revision  = OPTS_GET(opts, expected_revision, 0);
>>
>>          ret = sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
>>          return libbpf_err_errno(ret);
>>   }
>>
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index d9ec4407befa..a95d39bbef90 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -396,4 +396,5 @@ LIBBPF_1.3.0 {
>>          global:
>>                  bpf_obj_pin_opts;
>>                  bpf_program__attach_netfilter;
>> +               bpf_prog_detach_opts;
> 
> I think it sorts before bpf_program__attach_netfilter?

Yeap, also fixed.

