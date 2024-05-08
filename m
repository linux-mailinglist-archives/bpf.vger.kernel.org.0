Return-Path: <bpf+bounces-29029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5998BF6B1
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2674D2842AF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5032375B;
	Wed,  8 May 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqG4i5vp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA82BB0E;
	Wed,  8 May 2024 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715151648; cv=none; b=cBLl2lQ4Ghye+bMD8OQyaiEdTirXXrOu0r8aL3gqzmL36cdUNPxTEoeWFbmBqM8zrQklt3dGh4f3XRAZVOsqVHi6P5u39tsiO4oSZcpknOBoLUkosYkcdLfw73X2iI3UNTwVI7o379Wpiag1AbnZsGky8rO/6Rt6LrdY8pFEXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715151648; c=relaxed/simple;
	bh=LHSXmCmOtg5sXjJg7vqTUEWoeI0rETcoMNKOmxXoz6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LUYH89A6ZxT3Nj+Y+PSf0nzWQnhsApybiydqHArzNXm7EyIZ6zyyQ1jFtLkUQzoCj1DRay2XyKe9rvKpXW/Am0XlenIZL0ceM5IFyXWbMf75GKCEU4Rr0QGQlZnDsgMtXfFISAp46ToPNfjnmuoG7wbCUYAjceGBnIRAfjxHEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqG4i5vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C026C113CC;
	Wed,  8 May 2024 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715151647;
	bh=LHSXmCmOtg5sXjJg7vqTUEWoeI0rETcoMNKOmxXoz6Y=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=ZqG4i5vp0Xn5Wn8UQrQ5FyKJ/e2/vItEh+SlzJmtF64bsVQeDURqD9UsG1MWgslFD
	 AHfhPEY40lBnid9mjD08mVxrYLUATWZzwYCD5S4t1AZvYL/LQ0rm57qqczbwoSkPs7
	 DIS98Nhl/5CWpANxEBJduUp0+8M20tgUXqcvFyQ71YsrdoUJ4uGiCqNLGGHA0OmVBR
	 1TMuiyyn2T8Mr3Hu3a4suR8ra6SuvK2wBLBCt/PiIEY1BBbKXk0aaLWVXDXzLDGvrF
	 7euVhnKAiBmA+nIP69PfVbx5Vgirz7wFOO0r5hzVaLVLFa+xfe0t689k9oQWe7/IEX
	 NzxRv/ACjG9ug==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
Date: Wed, 8 May 2024 09:00:42 +0200
Cc: Kees Cook <keescook@chromium.org>,
 linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 jackmanb@google.com,
 renauld@google.com,
 casey@schaufler-ca.com,
 song@kernel.org,
 revest@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org> <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 8 May 2024, at 03:45, Paul Moore <paul@paul-moore.com> wrote:
>=20
> On Tue, May 7, 2024 at 8:01=E2=80=AFPM Kees Cook =
<keescook@chromium.org> wrote:
>>=20
>> On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
>>> [...]
>>> +/**
>>> + * security_toggle_hook - Toggle the state of the LSM hook.
>>> + * @hook_addr: The address of the hook to be toggled.
>>> + * @state: Whether to enable for disable the hook.
>>> + *
>>> + * Returns 0 on success, -EINVAL if the address is not found.
>>> + */
>>> +int security_toggle_hook(void *hook_addr, bool state)
>>> +{
>>> +     struct lsm_static_call *scalls =3D ((void =
*)&static_calls_table);
>>> +     unsigned long num_entries =3D
>>> +             (sizeof(static_calls_table) / sizeof(struct =
lsm_static_call));
>>> +     int i;
>>> +
>>> +     for (i =3D 0; i < num_entries; i++) {
>>> +             if (!scalls[i].hl)
>>> +                     continue;
>>> +
>>> +             if (scalls[i].hl->hook.lsm_func_addr !=3D hook_addr)
>>> +                     continue;
>>> +
>>> +             if (state)
>>> +                     static_branch_enable(scalls[i].active);
>>> +             else
>>> +                     static_branch_disable(scalls[i].active);
>>> +             return 0;
>>> +     }
>>> +     return -EINVAL;
>>> +}
>>=20
>> First of all: patches 1-4 are great. They have a measurable =
performance
>> benefit; let's get those in.
>>=20
>> But here I come to patch 5 where I will suggest the exact opposite of
>> what Paul said in v9 for patch 5. :P
>=20
> For those looking up v9 of the patchset, you'll be looking for patch
> *4*, not patch 5, as there were only four patches in the v9 series.
> Patch 4/5 in the v10 series is a new addition to the stack.
>=20
> Beyond that, I'm guessing you are referring to my comment regarding
> bpf_lsm_toggle_hook() Kees?  The one that starts with "More ugh.  If
> we are going to solve things this way ..."?
>=20
>> I don't want to have a global function that can be used to disable =
LSMs.
>> We got an entire distro (RedHat) to change their SELinux =
configurations
>> to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
>> CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
>> remove the runtime disable functionality"). We cannot reintroduce =
that,
>> and I'm hoping Paul will agree, given this reminder of LSM history. =
:)
>>=20
>> Run-time hook changing should be BPF_LSM specific, if it exists at =
all.


One idea here is that only LSM hooks with default_state =3D false can be =
toggled.=20

This would also any ROPs that try to abuse this function. Maybe we can =
call "default_disabled" .toggleable (or dynamic)

and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may =
be a fair middle ground?

Something like:

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4bd1d47bb9dc..5c0918ed6b80 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -117,7 +117,7 @@ struct security_hook_list {
        struct lsm_static_call  *scalls;
        union security_list_options     hook;
        const struct lsm_id             *lsmid;
-       bool                            default_enabled;
+       bool                            toggleable;
 } __randomize_layout;

 /*
@@ -168,14 +168,18 @@ static inline struct xattr =
*lsm_get_xattr_slot(struct xat>
        {                                               \
                .scalls =3D static_calls_table.NAME,      \
                .hook =3D { .NAME =3D HOOK },               \
-               .default_enabled =3D true                 \
+               .toggleable =3D false                     \
        }

-#define LSM_HOOK_INIT_DISABLED(NAME, HOOK)             \
+/*
+ * Toggleable LSM hooks are enabled at runtime with
+ * security_toggle_hook and are initialized as inactive.
+ */
+#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)           \
        {                                               \
                .scalls =3D static_calls_table.NAME,      \
                .hook =3D { .NAME =3D HOOK },               \
-               .default_enabled =3D false                \
+               .toggleable =3D true                      \
        }

 extern char *lsm_names;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index ed864f7430a3..ba1c3a19fb12 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -9,7 +9,7 @@

 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
        #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-       LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
+       LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
        #include <linux/lsm_hook_defs.h>
        #undef LSM_HOOK
        LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
+ * security_toggle_hook and are initialized as inactive.
+ */
+#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)           \
        {                                               \
                .scalls =3D static_calls_table.NAME,      \
                .hook =3D { .NAME =3D HOOK },               \
-               .default_enabled =3D false                \
+               .toggleable =3D true                      \
        }

 extern char *lsm_names;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index ed864f7430a3..ba1c3a19fb12 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -9,7 +9,7 @@

 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
        #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-       LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
+       LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
        #include <linux/lsm_hook_defs.h>
        #undef LSM_HOOK
        LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
kpsingh@kpsingh:~/projects/linux$ git diff
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4bd1d47bb9dc..5c0918ed6b80 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -117,7 +117,7 @@ struct security_hook_list {
        struct lsm_static_call  *scalls;
        union security_list_options     hook;
        const struct lsm_id             *lsmid;
-       bool                            default_enabled;
+       bool                            toggleable;
 } __randomize_layout;

 /*
@@ -168,14 +168,18 @@ static inline struct xattr =
*lsm_get_xattr_slot(struct xattr *xattrs,
        {                                               \
                .scalls =3D static_calls_table.NAME,      \
                .hook =3D { .NAME =3D HOOK },               \
-               .default_enabled =3D true                 \
+               .toggleable =3D false                     \
        }

-#define LSM_HOOK_INIT_DISABLED(NAME, HOOK)             \
+/*
+ * Toggleable LSM hooks are enabled at runtime with
+ * security_toggle_hook and are initialized as inactive.
+ */
+#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)           \
        {                                               \
                .scalls =3D static_calls_table.NAME,      \
                .hook =3D { .NAME =3D HOOK },               \
-               .default_enabled =3D false                \
+               .toggleable =3D true                      \
        }

 extern char *lsm_names;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index ed864f7430a3..ba1c3a19fb12 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -9,7 +9,7 @@

 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init =3D {
        #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-       LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
+       LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
        #include <linux/lsm_hook_defs.h>
        #undef LSM_HOOK
        LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
diff --git a/security/security.c b/security/security.c
index b3a92a67f325..a89eb8fe302b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -407,7 +407,8 @@ static void __init lsm_static_call_init(struct =
security_hook_list *hl)
                        __static_call_update(scall->key, =
scall->trampoline,
                                             hl->hook.lsm_func_addr);
                        scall->hl =3D hl;
-                       if (hl->default_enabled)
+                       /* Toggleable hooks are inactive by default */
+                       if (!hl->toggleable)
                                static_branch_enable(scall->active);
                        return;
                }
@@ -901,6 +902,9 @@ int security_toggle_hook(void *hook_addr, bool =
state)
        int i;

        for (i =3D 0; i < num_entries; i++) {
+               if (!scalls[i].hl->toggleable)
+                       continue;
+
                if (!scalls[i].hl)
                        continue;

- KP

>=20
> I don't want individual LSMs manipulating the LSM hook state directly;
> they go through the LSM layer to register their hooks, they should go
> through the LSM layer to unregister or enable/disable their hooks.
> I'm going to be pretty inflexible on this point.
>=20
> Honestly, I see this more as a problem in the BPF LSM design (although
> one might argue it's an implementation issue?), just as I saw the
> SELinux runtime disable as a problem.  If you're upset with the
> runtime hook disable, and you should be, fix the BPF LSM, don't force
> more bad architecture on the LSM layer.
>=20
> --=20
> paul-moore.com



