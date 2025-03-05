Return-Path: <bpf+bounces-53260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C591A4F2CF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76F93A5A31
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F327452;
	Wed,  5 Mar 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ht//rTAq"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D7915D1;
	Wed,  5 Mar 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135019; cv=none; b=aSTI2t33yzcpF9fJh1zGyn9ajCkVweiyvjrYD60pmVtyTPw5zbuT+C1ccKR0bfCIEEit8CpOIajZzSl8Ovk5CccLXzJ7Ti7hJnxc9I/1DsmnCF0g/gAR0RbEWE4BjPNcFAU+bAte+SY3ZXYatcrobmE7XzclrnGlVGn3yz1Y8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135019; c=relaxed/simple;
	bh=f65gu9zsK0uIrJL8tye93+UyjS25UdHt6GcdjFUHMlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhUpA/6uoxZlAW2kVMQCpxoX8goxKqlMPbi1jmrQBUtfbF9C78/Zglz5GIeNvqvygTTNVl/tchjf2CNKPWvaCoyJRCRWBTt0ufSWZMaBS3yGQHHKtBZMVeu3hahhKKqXprkhMdUtyuG7u5VJ3TcU3CUxzlAlsOG9EpXkuhWY8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ht//rTAq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id A57FD210EAF8;
	Tue,  4 Mar 2025 16:36:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A57FD210EAF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741135016;
	bh=0Yrz03GWRaNmKFRQL5d2IFkrSopl38bvM4bf0mF157A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ht//rTAqlaMLaCJ+Z0QYH09IJ/I0lXzAmJD3S0FAD1KEg2Tp46fVp/JbGuj1bR5L4
	 8bHmFX3ATYdH8s5kWWrgAFG61VRpjAWxxVCujlYWhsbEFmddH4rcYxjOM1AORf7cf1
	 HNvt+8YdU8xsellZ7QJ1qFO2ObgTtv/Dql/6u3y4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter
 to LSM/bpf test programs
In-Reply-To: <CAPhsuW5HJuRYPucfvDbs25un7_D8JJnt=7zNUJ1utY3O_VMeSw@mail.gmail.com>
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
 <CAPhsuW5HJuRYPucfvDbs25un7_D8JJnt=7zNUJ1utY3O_VMeSw@mail.gmail.com>
Date: Tue, 04 Mar 2025 16:36:44 -0800
Message-ID: <87a5a0jotf.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> On Tue, Mar 4, 2025 at 12:31=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> The security_bpf LSM hook now contains a boolean parameter specifying
>> whether an invocation of the bpf syscall originated from within the
>> kernel. Here, we update the function signature of relevant test
>> programs to include that new parameter.
>>
>> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> ^^^ The email address is broken.
>

Whoops, appologies, will get that fixed.=20

>> ---
>>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>>  7 files changed, 11 insertions(+), 10 deletions(-)
>
> It appears you missed a few of these?
>

Some of these don't require any changes. I ran into this as well while doin=
g a
search.=20

These are all accounted for in the patch.=20
> tools/testing/selftests/bpf/progs/rcu_read_lock.c:SEC("?lsm.s/bpf")
> tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm/bpf")
> tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm.s/bpf=
")
> tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s/b=
pf")
> tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s/b=
pf")
> tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("lsm.s/bp=
f")

security_bpf_map wasn't altered, it can't be called from the kernel. No
changes needed.
> tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c:SEC("ls=
m/bpf_map")

These are also all accounted for in the patch.=20
> tools/testing/selftests/bpf/progs/test_lookup_key.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/test_ptr_untrusted.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/test_task_under_cgroup.c:SEC("lsm.s/bpf=
")
> tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c:SEC("lsm.s/bpf")

bpf_token_cmd and bpf_token_capabable aren't callable from the kernel,
no changes to that hook either currently.

> tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_capable")
> tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_cmd")


This program doesn't take any parameters currently.
> tools/testing/selftests/bpf/progs/verifier_global_subprogs.c:SEC("?lsm/bp=
f")

These are all naked calls that don't take any explicit parameters.
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
> tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
>

-blaise

>>
>> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/t=
esting/selftests/bpf/progs/rcu_read_lock.c
>> index ab3a532b7dd6d..f85d0e282f2ae 100644
>> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
>> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
>> @@ -242,7 +242,8 @@ int inproper_sleepable_helper(void *ctx)
>>  }
>>
>>  SEC("?lsm.s/bpf")
>> -int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, u=
nsigned int size)
>> +int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, u=
nsigned int size,
>> +            bool is_kernel)
>>  {
>>         struct bpf_key *bkey;
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c =
b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
>> index 44628865fe1d4..0e741262138f2 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
>> @@ -51,13 +51,13 @@ static int bpf_link_create_verify(int cmd)
>>  }
>>
>>  SEC("lsm/bpf")
>> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
>> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size,=
 bool is_kernel)
>>  {
>>         return bpf_link_create_verify(cmd);
>>  }
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int siz=
e)
>> +int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int siz=
e, bool is_kernel)
>>  {
>>         return bpf_link_create_verify(cmd);
>>  }
>> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c=
 b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
>> index cd4d752bd089c..ce36a55ba5b8b 100644
>> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
>> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
>> @@ -36,7 +36,7 @@ char _license[] SEC("license") =3D "GPL";
>>
>>  SEC("?lsm.s/bpf")
>>  __failure __msg("cannot pass in dynptr at an offset=3D-8")
>> -int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned =
int size)
>> +int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned =
int size, bool is_kernel)
>>  {
>>         unsigned long val;
>>
>> @@ -46,7 +46,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr=
 *attr, unsigned int size)
>>
>>  SEC("?lsm.s/bpf")
>>  __failure __msg("arg#0 expected pointer to stack or const struct bpf_dy=
nptr")
>> -int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned =
int size)
>> +int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned =
int size, bool is_kernel)
>>  {
>>         unsigned long val =3D 0;
>>
>> @@ -55,7 +55,7 @@ int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr=
 *attr, unsigned int size)
>>  }
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned =
int size)
>> +int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned =
int size, bool is_kernel)
>>  {
>>         struct bpf_key *trusted_keyring;
>>         struct bpf_dynptr ptr;
>> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools=
/testing/selftests/bpf/progs/test_lookup_key.c
>> index c73776990ae30..c46077e01a4ca 100644
>> --- a/tools/testing/selftests/bpf/progs/test_lookup_key.c
>> +++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
>> @@ -23,7 +23,7 @@ extern struct bpf_key *bpf_lookup_system_key(__u64 id)=
 __ksym;
>>  extern void bpf_key_put(struct bpf_key *key) __ksym;
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
>> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, boo=
l is_kernel)
>>  {
>>         struct bpf_key *bkey;
>>         __u32 pid;
>> diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/to=
ols/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> index 2fdc44e766248..21fce1108a21d 100644
>> --- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> +++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
>> @@ -7,7 +7,7 @@
>>  char tp_name[128];
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
>> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size,=
 bool is_kernel)
>>  {
>>         switch (cmd) {
>>         case BPF_RAW_TRACEPOINT_OPEN:
>> diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c =
b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>> index 7e750309ce274..18ad24a851c6c 100644
>> --- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>> +++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>> @@ -49,7 +49,7 @@ int BPF_PROG(tp_btf_run, struct task_struct *task, u64=
 clone_flags)
>>  }
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
>> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size,=
 bool is_kernel)
>>  {
>>         struct cgroup *cgrp =3D NULL;
>>         struct task_struct *task;
>> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b=
/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>> index 12034a73ee2d2..135665f011c7e 100644
>> --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
>> @@ -37,7 +37,7 @@ struct {
>>  char _license[] SEC("license") =3D "GPL";
>>
>>  SEC("lsm.s/bpf")
>> -int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
>> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, boo=
l is_kernel)
>>  {
>>         struct bpf_dynptr data_ptr, sig_ptr;
>>         struct data *data_val;
>> --
>> 2.48.1
>>

