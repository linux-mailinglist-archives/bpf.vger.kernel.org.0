Return-Path: <bpf+bounces-26493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6918A0968
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F21F222BD
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229D13CF93;
	Thu, 11 Apr 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhTUtteq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513913DDBA;
	Thu, 11 Apr 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819566; cv=none; b=uCgM2/sUJghH9PeQaOtBFqZdWAfp0kSql2bc8mkz69iq58/RAMah1iS3E/+ZuQm3ESAka+D6VwOfxiw7RFkCoXqFzmBDtSIPnw+z9/JRdD3w35dXJNQCwx0CX+IYj0ULPb7ckQreltduayKRnKFNew3S0GJoLtmi2wNXwP2AMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819566; c=relaxed/simple;
	bh=qgtJ7uJlXWlZfBtuSaOH/toHDR8p7LHfHlMJuZyykcw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kphmI/r5G9tpQ8GBszpTbwOf8GoOaCKVSj5yCpMTX2VMXzGpH2COXzKWw4Dnec8kgjkrzDUczkAJPCwqRT7QnVc1IR32Wycl3kW+r4tRVGbaPhnquCrYiUvYYXA8iRHT9Oka8s6L1dinW39a41G1yemTdrUUBoyAKmdA6J9NPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhTUtteq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FAAC433C7;
	Thu, 11 Apr 2024 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819565;
	bh=qgtJ7uJlXWlZfBtuSaOH/toHDR8p7LHfHlMJuZyykcw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=BhTUtteq5nqkJP7ZumwpATvL0UIBTb66SPUzTO5dVQx/D1dMFeq/QSU0D4QGQQ3HI
	 nrXQ2gyuCXm/TlZc/Ybd/62msrG+Nmtzb7kwsYRSUQu5LMIgLxwupNEGj7CH8gflvo
	 HAEffSK8IuNkClGaapm70rkTOv1RDkh7/gwpQ/oMV8dMhRVSEvzdqun6dyT/CMaEz8
	 7pZUUEPSYHXuIRHIGfxZV6VYs1bhk7hRW9FEZM9okT4CoWmz6GUo0hAyoRUbjm1+9/
	 zucNJ/pPVvQzozbboy3US3Bh2UEJJi0qz6MpfC6JAvsKN+r8jHDh1d6ePoFe94vMNE
	 +kc/JRRnuxWzA==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v9 3/4] security: Replace indirect LSM hook calls with 
 static calls
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <a6689b0b5564461b829a18379eb3e83f@paul-moore.com>
Date: Thu, 11 Apr 2024 09:12:41 +0200
Cc: bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Kees Cook <keescook@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 song@kernel.org,
 daniel@iogearbox.net,
 ast@kernel.org,
 pabeni@redhat.com,
 andrii@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <492036A7-4944-4225-B045-3C2F79DBEA31@kernel.org>
References: <20240207124918.3498756-4-kpsingh@kernel.org>
 <a6689b0b5564461b829a18379eb3e83f@paul-moore.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 11 Apr 2024, at 02:38, Paul Moore <paul@paul-moore.com> wrote:
>=20
> On Feb  7, 2024 KP Singh <kpsingh@kernel.org> wrote:
>>=20
>> LSM hooks are currently invoked from a linked list as indirect calls
>> which are invoked using retpolines as a mitigation for speculative
>> attacks (Branch History / Target injection) and add extra overhead =
which
>> is especially bad in kernel hot paths:
>>=20
>> security_file_ioctl:
>>   0xffffffff814f0320 <+0>: endbr64
>>   0xffffffff814f0324 <+4>: push   %rbp
>>   0xffffffff814f0325 <+5>: push   %r15
>>   0xffffffff814f0327 <+7>: push   %r14
>>   0xffffffff814f0329 <+9>: push   %rbx
>>   0xffffffff814f032a <+10>: mov    %rdx,%rbx
>>   0xffffffff814f032d <+13>: mov    %esi,%ebp
>>   0xffffffff814f032f <+15>: mov    %rdi,%r14
>>   0xffffffff814f0332 <+18>: mov    $0xffffffff834a7030,%r15
>>   0xffffffff814f0339 <+25>: mov    (%r15),%r15
>>   0xffffffff814f033c <+28>: test   %r15,%r15
>>   0xffffffff814f033f <+31>: je     0xffffffff814f0358 =
<security_file_ioctl+56>
>>   0xffffffff814f0341 <+33>: mov    0x18(%r15),%r11
>>   0xffffffff814f0345 <+37>: mov    %r14,%rdi
>>   0xffffffff814f0348 <+40>: mov    %ebp,%esi
>>   0xffffffff814f034a <+42>: mov    %rbx,%rdx
>>=20
>>   0xffffffff814f034d <+45>: call   0xffffffff81f742e0 =
<__x86_indirect_thunk_array+352>
>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>=20
>>    Indirect calls that use retpolines leading to overhead, not just =
due
>>    to extra instruction but also branch misses.
>>=20
>>   0xffffffff814f0352 <+50>: test   %eax,%eax
>>   0xffffffff814f0354 <+52>: je     0xffffffff814f0339 =
<security_file_ioctl+25>
>>   0xffffffff814f0356 <+54>: jmp    0xffffffff814f035a =
<security_file_ioctl+58>
>>   0xffffffff814f0358 <+56>: xor    %eax,%eax
>>   0xffffffff814f035a <+58>: pop    %rbx
>>   0xffffffff814f035b <+59>: pop    %r14
>>   0xffffffff814f035d <+61>: pop    %r15
>>   0xffffffff814f035f <+63>: pop    %rbp
>>   0xffffffff814f0360 <+64>: jmp    0xffffffff81f747c4 =
<__x86_return_thunk>
>=20
> Generally I fix these up, but since there are quite a few long-ish =
lines
> in the description, and a respin is probably a good idea to reduce the
> merge fuzz, it would be good if you could manage the line lengths a =
bit
> better.  Aim to have the no wrapped lines in the commit description =
when
> you run 'git log' on a 80-char wide terminal.  I'm guessing that
> (re)formatting the assembly to something like this will solve most of
> the problems:
>=20
>  0xff...0360: jmp       0xff...47c4 <__x86_return_thunk>

Good idea. Will do.

>=20
>> The indirect calls are not really needed as one knows the addresses =
of
>> enabled LSM callbacks at boot time and only the order can possibly
>> change at boot time with the lsm=3D kernel command line parameter.
>>=20
>> An array of static calls is defined per LSM hook and the static calls
>> are updated at boot time once the order has been determined.
>>=20
>> A static key guards whether an LSM static call is enabled or not,
>> without this static key, for LSM hooks that return an int, the =
presence
>> of the hook that returns a default value can create side-effects =
which

[...]

>>   0xffffffff818f0d07 <+103>: int3
>>   0xffffffff818f0d08 <+104>: int3
>>   0xffffffff818f0d09 <+105>: int3
>>=20
>> While this patch uses static_branch_unlikely indicating that an LSM =
hook
>> is likely to be not present, a subsequent makes it configurable.
>=20
> I believe the comment above needs to be updated.

Done.

>=20
>> In most
>> cases this is still a better choice as even when an LSM with one hook =
is
>> added, empty slots are created for all LSM hooks (especially when =
many
>> LSMs that do not initialize most hooks are present on the system).
>>=20
>> There are some hooks that don't use the call_int_hook and
>> call_void_hook. These hooks are updated to use a new macro called
>> security_for_each_hook where the lsm_callback is directly invoked as =
an
>> indirect call. Currently, there are no performance sensitive hooks =
that
>> use the security_for_each_hook macro. However, if, some performance
>> sensitive hooks are discovered, these can be updated to use static =
calls
>> with loop unrolling as well using a custom macro.
>=20
> The security_for_each_hook() macro is not present in this patch.

Yeah, it was renamed to lsm_for_each_hook based on Casey's suggestion, I =
missed updating the message. Updated.

>=20
> Beyond that, let's find a way to use static calls in the LSM hooks
> which don't use the call_{int,void}_hook() macros.  If we're going to =
do
> this to help close some attack vectors, let's make sure we do the
> conversion everywhere.

This is surely doable, We can unroll the loop individually in these =
separate hooks. It would need separate=20

LSM_LOOP_UNROLL(__CALL_STATIC_xfrm_state_pol_flow_match, x, xp file)

Would you be okay if we do it in a follow up series? These are special =
hooks and I don't want to introduce any subtle logical bugs when fixing =
potential speculative side channels (Which could be fixed with =
retpolines, proper flushing at privilege changes etc).

>=20
>> Below are results of the relevant Unixbench system benchmarks with =
BPF LSM
>> and SELinux enabled with default policies enabled with and without =
these
>> patches.
>>=20
>> Benchmark                                               Delta(%): (+ =
is better)
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> Execl Throughput                                             +1.9356
>> File Write 1024 bufsize 2000 maxblocks                       +6.5953
>> Pipe Throughput                                              +9.5499
>> Pipe-based Context Switching                                 +3.0209
>> Process Creation                                             +2.3246
>> Shell Scripts (1 concurrent)                                 +1.4975
>> System Call Overhead                                         +2.7815
>> System Benchmarks Index Score (Partial Only):                +3.4859
>>=20
>> In the best case, some syscalls like eventfd_create benefitted to =
about ~10%.
>>=20
>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Song Liu <song@kernel.org>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>> ---
>> include/linux/lsm_hooks.h |  70 +++++++++--
>> security/security.c       | 244 =
++++++++++++++++++++++++--------------
>> 2 files changed, 216 insertions(+), 98 deletions(-)
>>=20


[...]

>> #undef LSM_HOOK
>> + void *lsm_callback;
>> };
>=20
> It took me a little while to figure out what you were doing with the
> lsm_callback field above, can we get rid of the "callback" bit and go
> with something to indicate this is a generic function address?  How
> about "lsm_func_addr" or similar (bikeshedding, I know ...)?
>=20
> I'd also like to see a one line comment in there too.

lsm_func_addr is actually better. Thanks.

>=20
>> -struct security_hook_heads {
>> - #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
>> - #include "lsm_hook_defs.h"
>> +/*
>> + * @key: static call key as defined by STATIC_CALL_KEY
>> + * @trampoline: static call trampoline as defined by =
STATIC_CALL_TRAMP
>> + * @hl: The security_hook_list as initialized by the owning LSM.
>> + * @active: Enabled when the static call has an LSM hook associated.
>> + */
>> +struct lsm_static_call {
>> + struct static_call_key *key;
>> + void *trampoline;
>> + struct security_hook_list *hl;
>> + /* this needs to be true or false based on what the key defaults to =
*/
>=20
> Isn't this "true or false based on if @hl is valid or not"?


See below, we are trying to avoid surplus branches and loads.

>=20
>> + struct static_key_false *active;
>> +} __randomize_layout;
>> +
>> +/*
>> + * Table of the static calls for each LSM hook.
>> + * Once the LSMs are initialized, their callbacks will be copied to =
these
>> + * tables such that the calls are filled backwards (from last to =
first).
>> + * This way, we can jump directly to the first used static call, and =
execute
>> + * all of them after. This essentially makes the entry point
>> + * dynamic to adapt the number of static calls to the number of =
callbacks.
>> + */
>> +struct lsm_static_calls_table {
>> + #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>> + struct lsm_static_call NAME[MAX_LSM_COUNT];
>> + #include <linux/lsm_hook_defs.h>
>> #undef LSM_HOOK
>> } __randomize_layout;
>>=20
>> @@ -58,10 +105,14 @@ struct lsm_id {
>> /*
>>  * Security module hook list structure.
>>  * For use with generic list macros for common operations.
>> + *
>> + * struct security_hook_list - Contents of a cacheable, mappable =
object.
>=20
> The comment above looks odd ... can you explain this a bit more and =
what
> your intention was with that line?


It's odd indeed. Been a while since I wrote it, I don't think that =
comemnt is actually needed, since the comment above it is explantory.

Will delete it.


>=20
>> + * @scalls: The beginning of the array of static calls assigned to =
this hook.
>> + * @hook: The callback for the hook.
>> + * @lsm: The name of the lsm that owns this hook.
>>  */
>> struct security_hook_list {
>> - struct hlist_node list;
>> - struct hlist_head *head;
>> + struct lsm_static_call *scalls;
>> union security_list_options hook;
>> const struct lsm_id *lsmid;
>> } __randomize_layout;
>> @@ -110,10 +161,12 @@ static inline struct xattr =
*lsm_get_xattr_slot(struct xattr *xattrs,
>>  * care of the common case and reduces the amount of
>>  * text involved.
>>  */
>> -#define LSM_HOOK_INIT(HEAD, HOOK) \
>> - { .head =3D &security_hook_heads.HEAD, .hook =3D { .HEAD =3D HOOK } =
}
>> +#define LSM_HOOK_INIT(NAME, CALLBACK) \
>> + { \
>> + .scalls =3D static_calls_table.NAME, \
>> + .hook =3D { .NAME =3D CALLBACK } \
>> + }
>=20
> Unless there is something that I'm missing, please just stick with the
> existing "HOOK" name instead of "CALLBACK".
>=20

fair, updated.

>> -extern struct security_hook_heads security_hook_heads;
>> extern char *lsm_names;
>>=20
>> extern void security_add_hooks(struct security_hook_list *hooks, int =
count,
>> @@ -151,5 +204,6 @@ extern struct lsm_info __start_early_lsm_info[], =
__end_early_lsm_info[];
>> __aligned(sizeof(unsigned long))
>>=20
>> extern int lsm_inode_alloc(struct inode *inode);
>> +extern struct lsm_static_calls_table static_calls_table =
__ro_after_init;
>>=20

[...]

>> /*
>> @@ -846,29 +906,41 @@ int lsm_fill_user_ctx(struct lsm_ctx __user =
*uctx, size_t *uctx_len,
>>  * call_int_hook:
>>  * This is a hook that returns a value.
>>  */
>> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)      \
>> +do {      \
>> + if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) { =
   \
>=20
> I'm not a fan of the likely()/unlikely() style markings/macros in =
cases
> like this as it can vary tremendously.  Drop the likely()/unlikely()
> checks and just do a static_call().
>=20
=20
These are actually not the the classical likely, unlikely macros which =
are just hints to the compiler:

#define likely(x) __builtin_expect(!!(x), 1)
#define unlikely(x) __builtin_expect(!!(x), 0


but a part of the static keys API which generates jump tables and the =
code generated depends on the (default state, likelyhood). It could have =
been named better, all we need is to have a jump table so that we can =
optimize this extra branch in hotpaths, in one direction.

   https://www.kernel.org/doc/Documentation/static-keys.txt


If you want I can put this behind a macro:


#define LSM_HOOK_ACTIVE(HOOK, NUM) =
static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)

the static_branch_likely / static_branch_unlikey actually does not =
matter much here, because without this we have a conditional branch and =
an extra load.


>> + static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);      \
>> + }      \
>> +} while (0);
>>=20
>> -#define call_void_hook(FUNC, ...) \
>> - do { \
>> - struct security_hook_list *P; \
>> - \
>> - hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>> - P->hook.FUNC(__VA_ARGS__); \
>> +#define call_void_hook(FUNC, ...)                                 \
>> + do {                                                      \
>> + LSM_LOOP_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__); \
>> } while (0)
>>=20
>> -#define call_int_hook(FUNC, IRC, ...) ({ \
>> - int RC =3D IRC; \
>> - do { \
>> - struct security_hook_list *P; \
>> - \
>> - hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>> - RC =3D P->hook.FUNC(__VA_ARGS__); \
>> - if (RC !=3D 0) \
>> - break; \
>> - } \
>> - } while (0); \
>> - RC; \
>> +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)      \
>> +do {      \
>> + if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) { =
 \
>=20
> See my comments in the void sister function.

See above.

>=20
>> + R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
>> + if (R !=3D 0)      \
>> + goto LABEL;      \
>> + }      \
>> +} while (0);
>> +
>> +#define call_int_hook(FUNC, IRC, ...) \
>> +({ \
>> + __label__ out; \
>> + int RC =3D IRC; \
>> + LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__); \
>> +out: \
>> + RC; \
>> })
>>=20
>> +#define lsm_for_each_hook(scall, NAME) \
>> + for (scall =3D static_calls_table.NAME; \
>> +      scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
>> + if (static_key_enabled(&scall->active->key))
>> +
>> /* Security operations */
>>=20
>=20
> --
> paul-moore.com



