Return-Path: <bpf+bounces-1409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D995714DC2
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2838B280F36
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0EBA926;
	Mon, 29 May 2023 16:03:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88728C0A
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 16:03:14 +0000 (UTC)
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [IPv6:2001:41d0:1004:224b::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899BB5
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 09:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685376189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BpPaNVh3M/kLmRVz5hBvyNbjyElZWOVG4f1mmasm1c=;
	b=Rx6FmJrLZz+JrwJg2HcNsEoYuNl2JCa5H9oYtbm2kTBr02hqFB4Etq+rGkAELrhPR3JYe+
	jJ60anH/+0ZPtNa5vup4bAJsdq8yLLyT8QblQlhEBn1lxmYMmmgi9JtQhZ4FdqB+kwAqU1
	GcURb/t/SAYH+p2MtPYrWTke0hVTWsg=
Date: Mon, 29 May 2023 16:03:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <a0d299517495a4f3c5015017b7bc67c2@linux.dev>
Subject: Re: [PATCH v6 RESEND] libbpf: kprobe.multi: Filter with
 available_filter_functions
To: "Jiri Olsa" <olsajiri@gmail.com>
Cc: andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 bpf@vger.kernel.org, liuyun01@kylinos.cn
In-Reply-To: <ZHSnVHGVDxiNZwxT@krava>
References: <ZHSnVHGVDxiNZwxT@krava>
 <20230526155026.1419390-1-liu.yun@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jiri.=0A=0A=0AMay 29, 2023 9:23 PM, "Jiri Olsa" <olsajiri@gmail.com> =
=E5=86=99=E5=88=B0:=0A=0A> On Fri, May 26, 2023 at 11:50:26PM +0800, Jack=
ie Liu wrote:=0A> =0A>> From: Jackie Liu <liuyun01@kylinos.cn>=0A>> =0A>>=
 When using regular expression matching with "kprobe multi", it scans all=
=0A>> the functions under "/proc/kallsyms" that can be matched. However, =
not all=0A>> of them can be traced by kprobe.multi. If any one of the fun=
ctions fails=0A>> to be traced, it will result in the failure of all func=
tions. The best=0A>> approach is to filter out the functions that cannot =
be traced to ensure=0A>> proper tracking of the functions.=0A>> =0A>> Use=
 available_filter_functions check first, if failed, fallback to=0A>> kall=
syms.=0A>> =0A>> Here is the test eBPF program [1].=0A>> [1] https://gith=
ub.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867=
=0A>> =0A>> Suggested-by: Jiri Olsa <olsajiri@gmail.com>=0A>> Signed-off-=
by: Jackie Liu <liuyun01@kylinos.cn>=0A>> ---=0A>> tools/lib/bpf/libbpf.c=
 | 100 ++++++++++++++++++++++++++++++++++++++---=0A>> 1 file changed, 93 =
insertions(+), 7 deletions(-)=0A>> =0A>> diff --git a/tools/lib/bpf/libbp=
f.c b/tools/lib/bpf/libbpf.c=0A>> index ad1ec893b41b..0914b7e98e30 100644=
=0A>> --- a/tools/lib/bpf/libbpf.c=0A>> +++ b/tools/lib/bpf/libbpf.c=0A>>=
 @@ -10106,6 +10106,12 @@ static const char *tracefs_uprobe_events(void)=
=0A>> return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_ev=
ents";=0A>> }=0A>> =0A>> +static const char *tracefs_available_filter_fun=
ctions(void)=0A>> +{=0A>> + return use_debugfs() ? DEBUGFS"/available_fil=
ter_functions" :=0A>> + TRACEFS"/available_filter_functions";=0A>> +}=0A>=
> +=0A>> static void gen_kprobe_legacy_event_name(char *buf, size_t buf_s=
z,=0A>> const char *kfunc_name, size_t offset)=0A>> {=0A>> @@ -10417,13 +=
10423,14 @@ static bool glob_match(const char *str, const char *pat)=0A>>=
 struct kprobe_multi_resolve {=0A>> const char *pattern;=0A>> unsigned lo=
ng *addrs;=0A>> + const char **syms;=0A>> size_t cap;=0A>> size_t cnt;=0A=
>> };=0A>> =0A>> static int=0A>> -resolve_kprobe_multi_cb(unsigned long l=
ong sym_addr, char sym_type,=0A>> - const char *sym_name, void *ctx)=0A>>=
 +kallsyms_resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_=
type,=0A>> + const char *sym_name, void *ctx)=0A>> {=0A>> struct kprobe_m=
ulti_resolve *res =3D ctx;=0A>> int err;=0A>> @@ -10440,6 +10447,77 @@ re=
solve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,=0A>> re=
turn 0;=0A>> }=0A>> =0A>> +static int ftrace_resolve_kprobe_multi_cb(cons=
t char *sym_name, void *ctx)=0A>> +{=0A>> + struct kprobe_multi_resolve *=
res =3D ctx;=0A>> + int err;=0A>> + char *name;=0A>> +=0A>> + if (!glob_m=
atch(sym_name, res->pattern))=0A>> + return 0;=0A>> +=0A>> + err =3D libb=
pf_ensure_mem((void **) &res->syms, &res->cap,=0A>> + sizeof(const char *=
), res->cnt + 1);=0A>> + if (err)=0A>> + return err;=0A>> +=0A>> + name =
=3D strdup(sym_name);=0A>> + if (!name)=0A>> + return -errno;=0A>> +=0A>>=
 + res->syms[res->cnt++] =3D name;=0A>> + return 0;=0A>> +}=0A>> +=0A>> +=
typedef int (*available_kprobe_cb_t)(const char *sym_name, void *ctx);=0A=
>> +=0A>> +static int=0A>> +libbpf_available_kprobes_parse(available_kpro=
be_cb_t cb, void *ctx)=0A>> +{=0A>> + char sym_name[256];=0A>> + FILE *f;=
=0A>> + int ret, err =3D 0;=0A>> + const char *available_path =3D tracefs=
_available_filter_functions();=0A>> +=0A>> + f =3D fopen(available_path, =
"r");=0A>> + if (!f) {=0A>> + err =3D -errno;=0A>> + pr_warn("failed to o=
pen %s, fallback to /proc/kallsyms.\n",=0A>> + available_path);=0A>> + re=
turn err;=0A>> + }=0A>> +=0A>> + while (true) {=0A>> + ret =3D fscanf(f, =
"%255s%*[^\n]\n", sym_name);=0A>> + if (ret =3D=3D EOF && feof(f))=0A>> +=
 break;=0A>> + if (ret !=3D 1) {=0A>> + pr_warn("failed to read available=
 kprobe entry: %d\n",=0A>> + ret);=0A>> + err =3D -EINVAL;=0A>> + break;=
=0A>> + }=0A>> +=0A>> + err =3D cb(sym_name, ctx);=0A>> + if (err)=0A>> +=
 break;=0A>> + }=0A>> +=0A>> + fclose(f);=0A>> + return err;=0A>> +}=0A>>=
 +=0A>> +static void kprobe_multi_resolve_free(struct kprobe_multi_resolv=
e *res)=0A>> +{=0A>> + while (res->syms && res->cnt)=0A>> + free((char *)=
res->syms[--res->cnt]);=0A>> +=0A>> + free(res->syms);=0A>> + free(res->a=
ddrs);=0A> =0A> I think we also need to zero the res->syms pointer, so th=
e final=0A> kprobe_multi_resolve_free won't try to release it again=0A> p=
erhaps use zfree for both syms and addrs=0A> =0A> other than this it look=
s ok to me:=0A> =0A> Acked-by: Jiri Olsa <jolsa@kernel.org>=0A=0AThank yo=
u for your patient guidance and best wishes to you.=0A=0AYou are right, I=
 finally decided to initialize all related variables to 0. We may indeed =
guarantee =0Athat res->cnt will become 0 now, but we will change the logi=
c in the future to miss this.=0A=0AThanks again.=0A=0A-- =0ABR, Jackie Li=
u=0A=0A> =0A> thanks,=0A> jirka=0A> =0A>> + /* reset cap to zero, when fa=
llback */=0A>> + res->cap =3D 0;=0A>> +}=0A>> +=0A>> struct bpf_link *=0A=
>> bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,=
=0A>> const char *pattern,=0A>> @@ -10476,13 +10554,21 @@ bpf_program__at=
tach_kprobe_multi_opts(const struct bpf_program *prog,=0A>> return libbpf=
_err_ptr(-EINVAL);=0A>> =0A>> if (pattern) {=0A>> - err =3D libbpf_kallsy=
ms_parse(resolve_kprobe_multi_cb, &res);=0A>> - if (err)=0A>> - goto erro=
r;=0A>> + err =3D libbpf_available_kprobes_parse(ftrace_resolve_kprobe_mu=
lti_cb,=0A>> + &res);=0A>> + if (err) {=0A>> + /* fallback to kallsyms */=
=0A>> + kprobe_multi_resolve_free(&res);=0A>> + err =3D libbpf_kallsyms_p=
arse(kallsyms_resolve_kprobe_multi_cb,=0A>> + &res);=0A>> + if (err)=0A>>=
 + goto error;=0A>> + }=0A>> if (!res.cnt) {=0A>> err =3D -ENOENT;=0A>> g=
oto error;=0A>> }=0A>> + syms =3D res.syms;=0A>> addrs =3D res.addrs;=0A>=
> cnt =3D res.cnt;=0A>> }=0A>> @@ -10511,12 +10597,12 @@ bpf_program__att=
ach_kprobe_multi_opts(const struct bpf_program *prog,=0A>> goto error;=0A=
>> }=0A>> link->fd =3D link_fd;=0A>> - free(res.addrs);=0A>> + kprobe_mul=
ti_resolve_free(&res);=0A>> return link;=0A>> =0A>> error:=0A>> free(link=
);=0A>> - free(res.addrs);=0A>> + kprobe_multi_resolve_free(&res);=0A>> r=
eturn libbpf_err_ptr(err);=0A>> }=0A>> =0A>> --=0A>> 2.25.1

