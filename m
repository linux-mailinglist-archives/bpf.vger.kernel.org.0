Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15868EC68
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 11:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBHKKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHKKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 05:10:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF945BE6
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 02:09:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so1050002wmb.2
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf4XlVtQi8m7bGt4x4ZeDS7v1V3hrF61tb2CLAZgXVw=;
        b=KWkGyi6A4r+R7zEF+pZX6lvzeYO/J60aIKKIqiX5y78Eu9Eg3aA7yIyIwj/7B1V8IK
         FPGmwvh9eJWE4rkoDP5HeO+jHJ+IfdxqpfjkgayoHF+JhjNgoTdP7tK9eV9VpkkBJpzY
         MJT/xFmnDwYsiUgzXtZ2geHSjdtSGwvutIgEMeEYEctQITVDyE0GlBfx8IojVbiNjGlz
         z9u3DXcrM9kOpeYGjEGv18Yp++rELJlyMNsUsRiJflUJrHptfsXPHPPQ973eVaLdcYFa
         Sl9Uhey16EBVtdGPF0wOgSiABRIvRGawdRcowpZOHx/rcB06Lvu5vSN2qhsLzKO6Zs9F
         2Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf4XlVtQi8m7bGt4x4ZeDS7v1V3hrF61tb2CLAZgXVw=;
        b=3pZVhHkIwpu9DoFbUJdEF3z37CzHoH68c70n1kfK+039oyfIlAnrPO3RFh5A3Xbtaf
         E0/67J3XvApSvzQaFnKbKgSxCSC8ZZ4VWWQvagzg6ObkswC0q4aFpGjEaan0KgOyur0S
         2LpHqwBHyFh+3SeNdepeDqHUhkypcfWfeqK6LuW6iAIw+MZBIemOomlxIwP4ODs/v9Ih
         uvmmaxvp6p7KK6xxxGZspTqpUiIAR7mFRCjnvXAKZ3lNxSy93kJjK8hwBklevIW6IWjc
         hkqOEOPuRn43Kn2Nec4mRq98E08brg1jRN8vrBj96uP5pjPCSR/dTPX1RQNnZjs1aPN3
         lJUg==
X-Gm-Message-State: AO0yUKXQn3iNRMlH0zND82YgIuBGEBIi/EUYmOscMA2w6APDxUXpE5zq
        Tn5Ki6gaSSzyyXtaWlOkLfPT07DeLyf2Pl+4
X-Google-Smtp-Source: AK7set9GeaSaKERk4+CCcVsbPZznctOyaleY/2N9txOY/ay9P6MWYgClbmMAmcsT3tuFzkcUh5AuKg==
X-Received: by 2002:a05:600c:4710:b0:3df:9858:c03d with SMTP id v16-20020a05600c471000b003df9858c03dmr1731878wmo.18.1675850981561;
        Wed, 08 Feb 2023 02:09:41 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b003dd1bd0b915sm1428138wms.22.2023.02.08.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:09:41 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 11:09:38 +0100
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv3 bpf-next 7/9] selftests/bpf: Allow to use kfunc from
 testmod.ko in test_verifier
Message-ID: <Y+N04gphOV/IsCxw@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-8-jolsa@kernel.org>
 <Y+JvgtTQvT7kd9wz@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+JvgtTQvT7kd9wz@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 07, 2023 at 09:34:26AM -0600, David Vernet wrote:
> On Fri, Feb 03, 2023 at 05:23:34PM +0100, Jiri Olsa wrote:
> > Currently the test_verifier allows test to specify kfunc symbol
> > and search for it in the kernel BTF.
> > 
> > Adding the possibility to search for kfunc also in bpf_testmod
> > module when it's not found in kernel BTF.
> > 
> > To find bpf_testmod btf we need to get back SYS_ADMIN cap.
> 
> This observation and any subsequent discussion is certainly outside the
> scope of your patch set, but it feels like a bit of a weird /
> inconsistent UX to force users to have SYS_ADMIN cap for loading kfuncs
> from modules, but not from vmlinux BTF.
> 
> I realize that you need to have SYS_ADMIN cap for BPF_PROG_GET_FD_BY_ID,
> BPF_MAP_GET_FD_BY_ID, etc, so the consistency makes sense there, but it
> would be nice if we could eventually make the UX consistent for programs
> linking against module kfuncs, because I don't really see the difference
> in terms of permissions from the user's perspective.

right, it's tricky.. I'm not sure if BPF_PROG_GET_FD_BY_ID could
work just with CAP_BPF.. will check

> 
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> LGTM in general -- just left one comment below.
> 
> Acked-by: David Vernet <void@manifault.com>
> 
> > ---
> >  tools/testing/selftests/bpf/test_verifier.c | 161 +++++++++++++++++---
> >  1 file changed, 139 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > index 14f11f2dfbce..0a570195be37 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -879,8 +879,140 @@ static int create_map_kptr(void)
> >  	return fd;
> >  }
> >  
> > +static void set_root(bool set)
> > +{
> > +	__u64 caps;
> > +
> > +	if (set) {
> > +		if (cap_enable_effective(1ULL << CAP_SYS_ADMIN, &caps))
> > +			perror("cap_disable_effective(CAP_SYS_ADMIN)");
> > +	} else {
> > +		if (cap_disable_effective(1ULL << CAP_SYS_ADMIN, &caps))
> > +			perror("cap_disable_effective(CAP_SYS_ADMIN)");
> > +	}
> > +}
> > +
> > +static inline __u64 ptr_to_u64(const void *ptr)
> > +{
> > +	return (__u64) (unsigned long) ptr;
> 
> Small nit / suggestion -- IMO this is slightly preferable just to keep
> it a bit more in-line with the C-standard:
> 
> return (uintptr_t)ptr;
> 
> The standard of course doesn't dictate that you can do
> ptr -> uintptr_t -> __u64 -> uintptr_t -> ptr, but it at least does dictate that you can do
> ptr -> uintptr_t -> ptr, whereas it does not say the same for
> ptr -> unsigned long -> ptr
> 
> Also, I don't think the 'inline' keyword is necessary. The compiler will
> probably figure this out on its own.

I copy&paste the ptr_to_u64 from some other test, sounds good, will check

> 
> > +}
> > +
> > +static struct btf *btf__load_testmod_btf(struct btf *vmlinux)
> 
> Would be nice if some of this code could be shared from libbpf at some
> point, but ok, a cleanup for another time.

ok

thanks,
jirka

> 
> > +{
> > +	struct bpf_btf_info info;
> > +	__u32 len = sizeof(info);
> > +	struct btf *btf = NULL;
> > +	char name[64];
> > +	__u32 id = 0;
> > +	int err, fd;
> > +
> > +	/* Iterate all loaded BTF objects and find bpf_testmod,
> > +	 * we need SYS_ADMIN cap for that.
> > +	 */
> > +	set_root(true);
> > +
> > +	while (true) {
> > +		err = bpf_btf_get_next_id(id, &id);
> > +		if (err) {
> > +			if (errno == ENOENT)
> > +				break;
> > +			perror("bpf_btf_get_next_id failed");
> > +			break;
> > +		}
> > +
> > +		fd = bpf_btf_get_fd_by_id(id);
> > +		if (fd < 0) {
> > +			if (errno == ENOENT)
> > +				continue;
> > +			perror("bpf_btf_get_fd_by_id failed");
> > +			break;
> > +		}
> > +
> > +		memset(&info, 0, sizeof(info));
> > +		info.name_len = sizeof(name);
> > +		info.name = ptr_to_u64(name);
> > +		len = sizeof(info);
> > +
> > +		err = bpf_obj_get_info_by_fd(fd, &info, &len);
> > +		if (err) {
> > +			close(fd);
> > +			perror("bpf_obj_get_info_by_fd failed");
> > +			break;
> > +		}
> > +
> > +		if (strcmp("bpf_testmod", name)) {
> > +			close(fd);
> > +			continue;
> > +		}
> > +
> > +		btf = btf__load_from_kernel_by_id_split(id, vmlinux);
> > +		if (!btf) {
> > +			close(fd);
> > +			break;
> > +		}
> > +
> > +		/* We need the fd to stay open so it can be used in fd_array.
> > +		 * The final cleanup call to btf__free will free btf object
> > +		 * and close the file descriptor.
> > +		 */
> > +		btf__set_fd(btf, fd);
> > +		break;
> > +	}
> > +
> > +	set_root(false);
> > +	return btf;
> > +}
> > +
> > +static struct btf *testmod_btf;
> > +static struct btf *vmlinux_btf;
> > +
> > +static void kfuncs_cleanup(void)
> > +{
> > +	btf__free(testmod_btf);
> > +	btf__free(vmlinux_btf);
> > +}
> > +
> > +static void fixup_prog_kfuncs(struct bpf_insn *prog, int *fd_array,
> > +			      struct kfunc_btf_id_pair *fixup_kfunc_btf_id)
> > +{
> > +	/* Patch in kfunc BTF IDs */
> > +	while (fixup_kfunc_btf_id->kfunc) {
> > +		int btf_id = 0;
> > +
> > +		/* try to find kfunc in kernel BTF */
> > +		vmlinux_btf = vmlinux_btf ?: btf__load_vmlinux_btf();
> > +		if (vmlinux_btf) {
> > +			btf_id = btf__find_by_name_kind(vmlinux_btf,
> > +							fixup_kfunc_btf_id->kfunc,
> > +							BTF_KIND_FUNC);
> > +			btf_id = btf_id < 0 ? 0 : btf_id;
> > +		}
> > +
> > +		/* kfunc not found in kernel BTF, try bpf_testmod BTF */
> > +		if (!btf_id) {
> > +			testmod_btf = testmod_btf ?: btf__load_testmod_btf(vmlinux_btf);
> > +			if (testmod_btf) {
> > +				btf_id = btf__find_by_name_kind(testmod_btf,
> > +								fixup_kfunc_btf_id->kfunc,
> > +								BTF_KIND_FUNC);
> > +				btf_id = btf_id < 0 ? 0 : btf_id;
> > +				if (btf_id) {
> > +					/* We put bpf_testmod module fd into fd_array
> > +					 * and its index 1 into instruction 'off'.
> > +					 */
> > +					*fd_array = btf__fd(testmod_btf);
> > +					prog[fixup_kfunc_btf_id->insn_idx].off = 1;
> > +				}
> > +			}
> > +		}
> > +
> > +		prog[fixup_kfunc_btf_id->insn_idx].imm = btf_id;
> > +		fixup_kfunc_btf_id++;
> > +	}
> > +}
> > +
> >  static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
> > -			  struct bpf_insn *prog, int *map_fds)
> > +			  struct bpf_insn *prog, int *map_fds, int *fd_array)
> >  {
> >  	int *fixup_map_hash_8b = test->fixup_map_hash_8b;
> >  	int *fixup_map_hash_48b = test->fixup_map_hash_48b;
> > @@ -905,7 +1037,6 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
> >  	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
> >  	int *fixup_map_timer = test->fixup_map_timer;
> >  	int *fixup_map_kptr = test->fixup_map_kptr;
> > -	struct kfunc_btf_id_pair *fixup_kfunc_btf_id = test->fixup_kfunc_btf_id;
> >  
> >  	if (test->fill_helper) {
> >  		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
> > @@ -1106,25 +1237,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
> >  		} while (*fixup_map_kptr);
> >  	}
> >  
> > -	/* Patch in kfunc BTF IDs */
> > -	if (fixup_kfunc_btf_id->kfunc) {
> > -		struct btf *btf;
> > -		int btf_id;
> > -
> > -		do {
> > -			btf_id = 0;
> > -			btf = btf__load_vmlinux_btf();
> > -			if (btf) {
> > -				btf_id = btf__find_by_name_kind(btf,
> > -								fixup_kfunc_btf_id->kfunc,
> > -								BTF_KIND_FUNC);
> > -				btf_id = btf_id < 0 ? 0 : btf_id;
> > -			}
> > -			btf__free(btf);
> > -			prog[fixup_kfunc_btf_id->insn_idx].imm = btf_id;
> > -			fixup_kfunc_btf_id++;
> > -		} while (fixup_kfunc_btf_id->kfunc);
> > -	}
> > +	fixup_prog_kfuncs(prog, fd_array, test->fixup_kfunc_btf_id);
> >  }
> >  
> >  struct libcap {
> > @@ -1451,6 +1564,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >  	int run_errs, run_successes;
> >  	int map_fds[MAX_NR_MAPS];
> >  	const char *expected_err;
> > +	int fd_array[2] = { -1, -1 };
> >  	int saved_errno;
> >  	int fixup_skips;
> >  	__u32 pflags;
> > @@ -1464,7 +1578,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >  	if (!prog_type)
> >  		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> >  	fixup_skips = skips;
> > -	do_test_fixup(test, prog_type, prog, map_fds);
> > +	do_test_fixup(test, prog_type, prog, map_fds, &fd_array[1]);
> >  	if (test->fill_insns) {
> >  		prog = test->fill_insns;
> >  		prog_len = test->prog_len;
> > @@ -1498,6 +1612,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >  	else
> >  		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
> >  	opts.prog_flags = pflags;
> > +	if (fd_array[1] != -1)
> > +		opts.fd_array = &fd_array[0];
> >  
> >  	if ((prog_type == BPF_PROG_TYPE_TRACING ||
> >  	     prog_type == BPF_PROG_TYPE_LSM) && test->kfunc) {
> > @@ -1740,6 +1856,7 @@ static int do_test(bool unpriv, unsigned int from, unsigned int to)
> >  	}
> >  
> >  	unload_bpf_testmod(verbose);
> > +	kfuncs_cleanup();
> >  
> >  	printf("Summary: %d PASSED, %d SKIPPED, %d FAILED\n", passes,
> >  	       skips, errors);
> > -- 
> > 2.39.1
> > 
