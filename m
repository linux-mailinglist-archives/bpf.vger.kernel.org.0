Return-Path: <bpf+bounces-63286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D2B04DA0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512E14A3482
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A572C08AA;
	Tue, 15 Jul 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPru4TY1"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71E1BCA07
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544749; cv=none; b=FWWiENK5AI46wG7ThYyIZelIomwjvvQSMrt1JVPrxMzmw1NBR/sVeVVzssFK7ijxUJQUiS/M9ftqPMpehPf16fxrKiYj1T1J0KxN+IPQGCj8sdMm42dKPk+Ne6N0MtkXFnL5jfol6KxB92810WOifHywWbbfxWCSuhhmV2uV5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544749; c=relaxed/simple;
	bh=52llm/pOyBBDJ4Yj7bRTPWY5JNVbouMuMXcgo4Rr6Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMDDeQMyFl3PlzScjw/JIiI2tKZ9KLZz8prmmNy/MO6G9J2TTxFD3GqzZYm1VBb9TqfafbdM9pQhcoRKGkCJZxE/az8qPGI5p2Q/M/Hv75scVXPJeY0GSBD0IFIHk8HkUHa2OLhGmp3LhkPW3lzDPeGMsSNw5A5bbr93EjEHMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPru4TY1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c389877-eafe-497a-a73e-720a3fcbcadb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752544743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwp3/NoM78qCE149XodCLZTW0PqWElenRwRdEttt5YI=;
	b=mPru4TY1ftzvs92Uj0AjUssnIn5oIA+Uida09XK/c/8EluCwKuRKvC+pE3ihh1m663hrvr
	0aFY2o4RcYn4Jomb4D18H/g6Mbqyr4sELsci+5BaFR5aJwgsWgFACHksy59bzbV2Y0pT9x
	1IX9UO3I9JVstvBqKE8k7MQhmTJwtxY=
Date: Tue, 15 Jul 2025 09:58:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 13/18] libbpf: support tracing_multi
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-14-dongml2@chinatelecom.cn>
 <CAEf4BzaxLm1qm-WxFKDWO0rHqUrvfg8sC0737MMKKQb77cRe7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4BzaxLm1qm-WxFKDWO0rHqUrvfg8sC0737MMKKQb77cRe7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:24 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> Add supporting for the attach types of:
>>
>> BPF_TRACE_FENTRY_MULTI
>> BPF_TRACE_FEXIT_MULTI
>> BPF_MODIFY_RETURN_MULTI
>>
>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   tools/bpf/bpftool/common.c |   3 +
>>   tools/lib/bpf/bpf.c        |  10 +++
>>   tools/lib/bpf/bpf.h        |   6 ++
>>   tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
>>   tools/lib/bpf/libbpf.h     |  19 +++++
>>   tools/lib/bpf/libbpf.map   |   1 +
>>   6 files changed, 204 insertions(+), 3 deletions(-)
>>
> [...]
>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 1342564214c8..5c97acec643d 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -422,6 +422,12 @@ struct bpf_link_create_opts {
>>                  struct {
>>                          __u64 cookie;
>>                  } tracing;
>> +               struct {
>> +                       __u32 cnt;
>> +                       const __u32 *btf_ids;
>> +                       const __u32 *tgt_fds;
> tgt_fds are always BTF FDs, right? Do we intend to support
> freplace-style multi attachment at all? If not, I'd name them btf_fds,
> and btf_ids -> btf_type_ids (because BTF ID can also refer to kernel
> ID of BTF object, so ambiguous and somewhat confusing)


For now, freplace is not supported. And I'm not sure if we will support

it in the feature.


I think that there should be no need to use freplace in large quantities,

so we don't need to support the multi attachment for it in the feature.


Yeah, I'll follow your advice in the next version.


>
>> +                       const __u64 *cookies;
>> +               } tracing_multi;
>>                  struct {
>>                          __u32 pf;
>>                          __u32 hooknum;
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 530c29f2f5fc..ae38b3ab84c7 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -136,6 +136,9 @@ static const char * const attach_type_name[] = {
>>          [BPF_NETKIT_PEER]               = "netkit_peer",
>>          [BPF_TRACE_KPROBE_SESSION]      = "trace_kprobe_session",
>>          [BPF_TRACE_UPROBE_SESSION]      = "trace_uprobe_session",
>> +       [BPF_TRACE_FENTRY_MULTI]        = "trace_fentry_multi",
>> +       [BPF_TRACE_FEXIT_MULTI]         = "trace_fexit_multi",
>> +       [BPF_MODIFY_RETURN_MULTI]       = "modify_return_multi",
>>   };
>>
>>   static const char * const link_type_name[] = {
>> @@ -410,6 +413,8 @@ enum sec_def_flags {
>>          SEC_XDP_FRAGS = 16,
>>          /* Setup proper attach type for usdt probes. */
>>          SEC_USDT = 32,
>> +       /* attachment target is multi-link */
>> +       SEC_ATTACH_BTF_MULTI = 64,
>>   };
>>
>>   struct bpf_sec_def {
>> @@ -7419,9 +7424,9 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>                  opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
>>          }
>>
>> -       if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>> +       if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->attach_btf_id) {
>>                  int btf_obj_fd = 0, btf_type_id = 0, err;
>> -               const char *attach_name;
>> +               const char *attach_name, *name_end;
>>
>>                  attach_name = strchr(prog->sec_name, '/');
>>                  if (!attach_name) {
>> @@ -7440,7 +7445,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>                  }
>>                  attach_name++; /* skip over / */
>>
>> -               err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd, &btf_type_id);
>> +               name_end = strchr(attach_name, ',');
>> +               /* for multi-link tracing, use the first target symbol during
>> +                * loading.
>> +                */
>> +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
>> +                       int len = name_end - attach_name + 1;
> for multi-kprobe we decided to only support a single glob  as a target
> in declarative SEC() definition. If a user needs more control, they
> can always fallback to the programmatic bpf_program__attach_..._opts()
> variant. Let's do the same here, glob is good enough for declarative
> use cases, and for complicated cases programmatic is the way to go
> anyways. You'll avoid unnecessary complications like this one then.


In fact, this is to make the BPF code in the selftests simple. With such

control, I can test different combination of the target functions easily,

just like this:


SEC("fentry.multi/bpf_testmod_test_struct_arg_1,bpf_testmod_test_struct_arg_13")
int BPF_PROG2(fentry_success_test1, struct bpf_testmod_struct_arg_2, a)
{
     test_result = a.a + a.b;
     return 0;
}

SEC("fentry.multi/bpf_testmod_test_struct_arg_2,bpf_testmod_test_struct_arg_10")
int BPF_PROG2(fentry_success_test2, int, a, struct 
bpf_testmod_struct_arg_2, b)
{
     test_result = a + b.a + b.b;
     return 0;
}


And you are right, we should design it for the users, and a single glob is

much better. Instead, I'll implement the combination testings in the

loader with bpf_program__attach_trace_multi_opts().


>
> BTW, it's not trivial to figure this out from earlier patches, but
> does BPF verifier need to know all these BTF type IDs during program
> verification time? If yes, why and then why do we need to specify them
> during LINK_CREATE time. And if not, then great, and we don't need to
> parse all this during load time.


It doesn't need to know all the BTF type IDs, but it need to know one

of them(the first one), which means that we still need to do the parse

during load time.


Of course, we can split it:

step 1: parse the glob and get the first BTF type ID during load time

step 2: parse the glob and get all the BTF type IDs during attachment


But it will make the code a little more complex. Shoud I do it this way?

I'd appreciate it to hear some advice here :/


>
>> +                       char *first_tgt;
>> +
>> +                       first_tgt = malloc(len);
>> +                       if (!first_tgt)
>> +                               return -ENOMEM;
>> +                       libbpf_strlcpy(first_tgt, attach_name, len);
>> +                       first_tgt[len - 1] = '\0';
>> +                       err = libbpf_find_attach_btf_id(prog, first_tgt, &btf_obj_fd,
>> +                                                       &btf_type_id);
>> +                       free(first_tgt);
>> +               } else {
>> +                       err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd,
>> +                                                       &btf_type_id);
>> +               }
>> +
>>                  if (err)
>>                          return err;
>>
>> @@ -9519,6 +9544,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
>>   static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>>   static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>>   static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>> +static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>>
>>   static const struct bpf_sec_def section_defs[] = {
>>          SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
>> @@ -9565,6 +9591,13 @@ static const struct bpf_sec_def section_defs[] = {
>>          SEC_DEF("fentry.s+",            TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>>          SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>>          SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>> +       SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
> duplicate


Get it :/


Thanks!

Menglong Dong


>
>
>> +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
>> +       SEC_DEF("fmod_ret.multi+",      TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
>> +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
>> +       SEC_DEF("fentry.multi.s+",      TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
>> +       SEC_DEF("fmod_ret.multi.s+",    TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
>> +       SEC_DEF("fexit.multi.s+",       TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
>>          SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_trace),
>>          SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
>>          SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
>> @@ -12799,6 +12832,135 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
>>          return libbpf_get_error(*link);
>>   }
>>
> [...]
>

