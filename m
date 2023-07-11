Return-Path: <bpf+bounces-4765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A17F74F13B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE912816A6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418EF19BB2;
	Tue, 11 Jul 2023 14:08:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130914AB5;
	Tue, 11 Jul 2023 14:08:55 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828A1718;
	Tue, 11 Jul 2023 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KvskEr1+W018J0txnL09dpVdxdmlYOmO19RB1YOkiX4=; b=QzzxCCWiGG/VQxMp0cx8ETfcYe
	ee9q511MvrIs6KEeFeXKl9Q2Ab8xIVQIj9sxOsDxAeWwx1OBTvYuGPgtlZpa8ID81ZlSN+SHcev4i
	kxUk6BU6T25lL1ujp3sz2yPkbm19g6v7qtrfT9SxTfcWgd5PC0XFXhBJdn476WJzoUPPi5H9Dsz6c
	nl6/xsvq367h3aRnl51pfqKmZv0js4zblg88EMKBfOyCp4tAoXQF4f3ZV5TnZazAOX34Ft5IRpDw2
	MapqoAOPu0wn0Kt4tk5APqsOrr3v2UefrmXVHTBQdBZbqJvhthK/4IgdGh3E7gKKTcaWNuQuMYSip
	BkRX6wKQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJE2G-0000Zl-8q; Tue, 11 Jul 2023 16:08:12 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJE2F-000FCG-PN; Tue, 11 Jul 2023 16:08:11 +0200
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Add link-based API for tcx
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-5-daniel@iogearbox.net>
 <CAEf4Bzb_qyd9KbNU6=vs=H3Nbqt6QNNo++JVRCUrQ9aFW4psMA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a98f7531-b8a9-909b-0eb3-38bf26d79115@iogearbox.net>
Date: Tue, 11 Jul 2023 16:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzb_qyd9KbNU6=vs=H3Nbqt6QNNo++JVRCUrQ9aFW4psMA@mail.gmail.com>
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
>> Implement tcx BPF link support for libbpf.
>>
>> The bpf_program__attach_fd() API has been refactored slightly in order to pass
>> bpf_link_create_opts pointer as input.
>>
>> A new bpf_program__attach_tcx() has been added on top of this which allows for
>> passing all relevant data via extensible struct bpf_tcx_opts.
>>
>> The program sections tcx/ingress and tcx/egress correspond to the hook locations
>> for tc ingress and egress, respectively.
>>
>> For concrete usage examples, see the extensive selftests that have been
>> developed as part of this series.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   tools/lib/bpf/bpf.c      | 19 ++++++++++--
>>   tools/lib/bpf/bpf.h      |  5 ++++
>>   tools/lib/bpf/libbpf.c   | 62 ++++++++++++++++++++++++++++++++++------
>>   tools/lib/bpf/libbpf.h   | 16 +++++++++++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   5 files changed, 92 insertions(+), 11 deletions(-)
>>
> 
> Pretty minor nits, I think ifindex move to be mandatory argument is
> the most consequential, as it's an API. With that addressed, please
> add my ack for next rev
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 3dfc43b477c3..d513c226b9aa 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -717,9 +717,9 @@ int bpf_link_create(int prog_fd, int target_fd,
>>                      const struct bpf_link_create_opts *opts)
>>   {
>>          const size_t attr_sz = offsetofend(union bpf_attr, link_create);
>> -       __u32 target_btf_id, iter_info_len;
>> +       __u32 target_btf_id, iter_info_len, relative_id;
>> +       int fd, err, relative;
> 
> nit: maybe make these new vars local to the TCX cases branch below?
> 
>>          union bpf_attr attr;
>> -       int fd, err;
>>
>>          if (!OPTS_VALID(opts, bpf_link_create_opts))
>>                  return libbpf_err(-EINVAL);
>> @@ -781,6 +781,21 @@ int bpf_link_create(int prog_fd, int target_fd,
>>                  if (!OPTS_ZEROED(opts, netfilter))
>>                          return libbpf_err(-EINVAL);
>>                  break;
>> +       case BPF_TCX_INGRESS:
>> +       case BPF_TCX_EGRESS:
>> +               relative = OPTS_GET(opts, tcx.relative_fd, 0);
>> +               relative_id = OPTS_GET(opts, tcx.relative_id, 0);
>> +               if (relative > 0 && relative_id)
>> +                       return libbpf_err(-EINVAL);
>> +               if (relative_id) {
>> +                       relative = relative_id;
>> +                       attr.link_create.flags |= BPF_F_ID;
>> +               }
> 
> Well, I have the same nit as in the previous patch, this "relative =
> relative_id" is both confusing because of naming asymmetry (no
> relative_fd throws me off), and also unnecessary updating of the
> state. link_create.flags |= BPF_F_ID is inevitable, but the rest can
> be more straightforward, IMO
> 
>> +               attr.link_create.tcx.relative_fd = relative;
>> +               attr.link_create.tcx.expected_revision = OPTS_GET(opts, tcx.expected_revision, 0);
>> +               if (!OPTS_ZEROED(opts, tcx))
>> +                       return libbpf_err(-EINVAL);
>> +               break;
>>          default:
>>                  if (!OPTS_ZEROED(opts, flags))
>>                          return libbpf_err(-EINVAL);
> 
> [...]
> 
>> +struct bpf_link *
>> +bpf_program__attach_tcx(const struct bpf_program *prog,
>> +                       const struct bpf_tcx_opts *opts)
>> +{
>> +       LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
>> +       __u32 relative_id, flags;
>> +       int ifindex, relative_fd;
>> +
>> +       if (!OPTS_VALID(opts, bpf_tcx_opts))
>> +               return libbpf_err_ptr(-EINVAL);
>> +
>> +       relative_id = OPTS_GET(opts, relative_id, 0);
>> +       relative_fd = OPTS_GET(opts, relative_fd, 0);
>> +       flags = OPTS_GET(opts, flags, 0);
>> +       ifindex = OPTS_GET(opts, ifindex, 0);
>> +
>> +       /* validate we don't have unexpected combinations of non-zero fields */
>> +       if (!ifindex) {
>> +               pr_warn("prog '%s': target netdevice ifindex cannot be zero\n",
>> +                       prog->name);
>> +               return libbpf_err_ptr(-EINVAL);
>> +       }
> 
> given ifindex is non-optional, then it makes more sense to have it as
> a mandatory argument between prog and opts in
> bpf_program__attach_tcx(), instead of as a field of an opts struct

Agree, and it will also be more in line with bpf_program__attach_xdp() one
which has ifindex as 2nd param too.

I also implemented the rest of the suggestions in here for v5, thanks!

>> +       if (relative_fd > 0 && relative_id) {
> 
> this asymmetrical check is a bit distracting. And also, if someone
> specifies negative FD and positive ID, that's also a bad combo and we
> shouldn't just ignore invalid FD, right? So I'd have a nice and clean
> 
> if (relative_fd && relative_id) { /* bad */ }
> 
>> +               pr_warn("prog '%s': relative_fd and relative_id cannot be set at the same time\n",
>> +                       prog->name);
>> +               return libbpf_err_ptr(-EINVAL);
>> +       }
>> +       if (relative_id)
>> +               flags |= BPF_F_ID;
> 
> I think bpf_link_create() will add this flag anyways, so can drop this
> adjustment logic here?
> 
>> +
>> +       link_create_opts.tcx.expected_revision = OPTS_GET(opts, expected_revision, 0);
>> +       link_create_opts.tcx.relative_fd = relative_fd;
>> +       link_create_opts.tcx.relative_id = relative_id;
>> +       link_create_opts.flags = flags;
>> +
>> +       /* target_fd/target_ifindex use the same field in LINK_CREATE */
>> +       return bpf_program_attach_fd(prog, ifindex, "tc", &link_create_opts);
> 
> s/tc/tcx/ ?
> 
>>   }
>>
>>   struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
>> @@ -11917,11 +11956,16 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
>>          }
>>
>>          if (target_fd) {
>> +               LIBBPF_OPTS(bpf_link_create_opts, target_opts);
>> +
>>                  btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
>>                  if (btf_id < 0)
>>                          return libbpf_err_ptr(btf_id);
>>
>> -               return bpf_program__attach_fd(prog, target_fd, btf_id, "freplace");
>> +               target_opts.target_btf_id = btf_id;
>> +
>> +               return bpf_program_attach_fd(prog, target_fd, "freplace",
>> +                                            &target_opts);
>>          } else {
>>                  /* no target, so use raw_tracepoint_open for compatibility
>>                   * with old kernels
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 10642ad69d76..33f60a318e81 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -733,6 +733,22 @@ LIBBPF_API struct bpf_link *
>>   bpf_program__attach_netfilter(const struct bpf_program *prog,
>>                                const struct bpf_netfilter_opts *opts);
>>
>> +struct bpf_tcx_opts {
>> +       /* size of this struct, for forward/backward compatibility */
>> +       size_t sz;
>> +       int ifindex;
> 
> is ifindex optional or it's expected to always be specified? If the
> latter, then I'd move ifindex out of opts and make it second arg of
> bpf_program__attach_tcx, between prog and opts
> 
>> +       __u32 flags;
>> +       __u32 relative_fd;
>> +       __u32 relative_id;
>> +       __u64 expected_revision;
>> +       size_t :0;
>> +};
>> +#define bpf_tcx_opts__last_field expected_revision
>> +
>> +LIBBPF_API struct bpf_link *
>> +bpf_program__attach_tcx(const struct bpf_program *prog,
>> +                       const struct bpf_tcx_opts *opts);
>> +
>>   struct bpf_map;
>>
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index a95d39bbef90..2a2db5c78048 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -397,4 +397,5 @@ LIBBPF_1.3.0 {
>>                  bpf_obj_pin_opts;
>>                  bpf_program__attach_netfilter;
>>                  bpf_prog_detach_opts;
>> +               bpf_program__attach_tcx;
> 
> heh, now we definitely screwed up sorting ;)
> 
>>   } LIBBPF_1.2.0;
> 
>> --
>> 2.34.1
>>
> 


