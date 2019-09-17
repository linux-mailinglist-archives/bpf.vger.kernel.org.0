Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84741B5645
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2019 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfIQTgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Sep 2019 15:36:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42859 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfIQTgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Sep 2019 15:36:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so4407837ede.9
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2019 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEzeIlbKlL6n+a91/2Apz9ZsfDadi6kbPy+pZ7otMAc=;
        b=H2xgkV8XRZBNaEYaVm/io/KVMGNYjXLhoKXM5l0gc7mRmEfRyBiBE9EybW2GXYPe8h
         Fs5I5JXBuC1D+ZDvd7BAbzUsQy1JlVkdTNjQBsLUQt7jKNKGb+Oung+mSqLLMr/P8VEm
         iRKKlVDfwq8WBmjAtBNlSHPntWSu1OaLzKx+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEzeIlbKlL6n+a91/2Apz9ZsfDadi6kbPy+pZ7otMAc=;
        b=cRqIJGR3dEd7AM4ctwetRuZW9r731V9lG3eBYhKQzo2OkTquitV+FGUid6xcdlx/7Q
         aDImWG7vbvEUm7v/V5b9+BB3r2J7ApeKq/cDATUap7E8HuUdbGXfuZTSHr/j12VMZ8Eb
         EyPLv2VpxEw0dM3fvpTFN8MIpQ+FyqG6FqzxTkHt3IR6FMFleUUAhtk9FAYH5ahMiO8i
         m8tha2RrE+4+IwO86i7c6CUnKwm9M9YB4vOKihOQkS5lVQtqJrMpO1BDnMj/ZmvTHgDQ
         2ibxRDkmlAHw+ajqevzr2X69mE9TtpKT3uZVIPWAD3r14S6eQj5/RBa8GTpbE74jyi2w
         NkeQ==
X-Gm-Message-State: APjAAAVN89dkbCpf1SzZze9fF4fMOhCzk+Xq1ElpXlDa6TqIpcl80Toh
        1GqsXHOjKGkq2YSCuYuMza/cfw==
X-Google-Smtp-Source: APXvYqylayCvFvwmQwR3E3AG4P0SDgxSU35fbiUHSqPTvW1r0z62dQQsQoLj4ORMQBuUp1W+Bs8ddQ==
X-Received: by 2002:aa7:dd11:: with SMTP id i17mr6682652edv.147.1568748988172;
        Tue, 17 Sep 2019 12:36:28 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i5sm593967edq.30.2019.09.17.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:36:27 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 17 Sep 2019 21:36:25 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [RFC v1 12/14] krsi: Add an eBPF helper function to get the
 value of an env variable
Message-ID: <20190917193625.GA32191@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-13-kpsingh@chromium.org>
 <0a5386c9-3dbd-1ed8-d94c-d866c6369743@fb.com>
 <20190916130043.GA64010@google.com>
 <66d5a0b2-8ea1-cdb1-87b6-71021d875296@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d5a0b2-8ea1-cdb1-87b6-71021d875296@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 17-Sep 16:58, Yonghong Song wrote:
> 
> 
> On 9/16/19 6:00 AM, KP Singh wrote:
> > Thanks for reviewing!
> > 
> > On 15-Sep 00:16, Yonghong Song wrote:
> >>
> >>
> >> On 9/10/19 12:55 PM, KP Singh wrote:
> >>> From: KP Singh <kpsingh@google.com>
> >>
> >> This patch cannot apply cleanly.
> >>
> >> -bash-4.4$ git apply ~/p12.txt
> >> error: patch failed: include/uapi/linux/bpf.h:2715
> >> error: include/uapi/linux/bpf.h: patch does not apply
> >> error: patch failed: tools/include/uapi/linux/bpf.h:2715
> >> error: tools/include/uapi/linux/bpf.h: patch does not apply
> >> -bash-4.4$
> > 
> > I am not sure why this is happening, I tried:
> > 
> > git clone \
> >    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git && \
> >    cd linux-next && \
> >    git checkout -b review v5.3-rc6 && \
> >    wget -P /tmp https://lore.kernel.org/patchwork/series/410101/mbox && \
> >    git am /tmp/mbox
> > 
> > and it worked.
> > 
> > This seems to work too:
> > 
> >    patch -p1 < <file>.patch
> > 
> > Can you try with "git am" please?
> 
> Will try next time when reviewing the tree.

Thanks!

> 
> > 
> >>
> >>>
> >>> The helper returns the value of the environment variable in the buffer
> >>> that is passed to it. If the var is set multiple times, the helper
> >>> returns all the values as null separated strings.
> >>>
> >>> If the buffer is too short for these values, the helper tries to fill it
> >>> the best it can and guarantees that the value returned in the buffer
> >>> is always null terminated. After the buffer is filled, the helper keeps
> >>> counting the number of times the environment variable is set in the
> >>> envp.
> >>>
> >>> The return value of the helper is an u64 value which carries two pieces
> >>> of information.
> >>>
> >>>     * The upper 32 bits are a u32 value signifying the number of times
> >>>       the environment variable is set in the envp.
> >>
> >> Not sure how useful this 'upper 32' bit value is. What user expected to do?
> >>
> >> Another option is to have upper 32 bits encode the required buffer size
> >> to hold all values. This may cause some kind of user space action, e.g.,
> >> to replace the program with new program with larger per cpu map value size?
> >>
> > 
> > The upper 32-bit value is actually an important part of the LSM's MAC
> > policy. It allows the user to:
> > 
> > - Return an -EPERM when if the environment variable is set more than
> >    once.
> > - Log a warning (this is what we are doing in the example) so
> >    this is flagged as a potential malicious actor.
> 
> So the intention is to catch cases where the env variable
> to set by more than once, not exactly to capture all the values
> of the env variable.
> 
> Then may be there is no need to record the values once the number of 
> values is more than one? Do you have use case for what user to react if
> there are more than one setting?

Since KRSI intends to be an API for creating MAC and Audit Policies,
it would be best to leave the decision to the user, as to what they 
intend to do with the extra information. In general, having both the 
values helps in building more context about the potential malicious actor.

What should ideally be done is returning an -EPERM error, because there
should be no reason to set an env variable twice. 
In fact, two+ env vars can only be passed directly to the 
execve system call arguments. Shells (e.g. bash) remove the duplicate 
value before passing the envv to the system call.

> 
> > 
> >>>     * The lower 32 bits are a s32 value signifying the number of bytes
> >>>       written to the buffer or an error code. >
> >>> Since the value of the environment variable can be very long and exceed
> >>> what can be allocated on the BPF stack, a per-cpu array can be used
> >>> instead:
> >>>
> >>> struct bpf_map_def SEC("maps") env_map = {
> >>>           .type = BPF_MAP_TYPE_PERCPU_ARRAY,
> >>>           .key_size = sizeof(u32),
> >>>           .value_size = 4096,
> >>>           .max_entries = 1,
> >>> };
> >>
> >> Could you use use map definition with SEC(".maps")?
> > 
> > Sure, I added this example program in the commit message. Will update
> > it to be more canonical. Thanks!
> > 
> >>
> >>>
> >>> SEC("prgrm")
> >>> int bpf_prog1(void *ctx)
> >>> {
> >>>           u32 map_id = 0;
> >>>           u64 times_ret;
> >>>           s32 ret;
> >>>           char name[48] = "LD_PRELOAD";
> >>
> >> Reverse Christmas tree coding style, here and other places?
> > 
> > Will happily fix it.
> > 
> > However, I did not find it mentioned in the style guide:
> > 
> >    https://www.kernel.org/doc/html/v4.10/process/coding-style.html
> >    https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_v4.6_source_Documentation_CodingStyle&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=G_3dpLivr0lLqQlQqAVEw9EZB3GonzJjILyCBqbmMIo&s=krLmTogyg9eSdco0j4tv2etr4PmNEPZGXMMoOkWdVG4&e=
> > 
> > Is there one specific to BPF?
> 
> I forgot where is the documentation. We follow this for bpf/net.

Thanks, I searched and found some threads where this is recommended
for bpf/net. I will update it in the next iteration.

> 
> > 
> > 
> >>
> >>>
> >>>           char *map_value = bpf_map_lookup_elem(&env_map, &map_id);
> >>>           if (!map_value)
> >>>                   return 0;
> >>>
> >>>           // Read the lower 32 bits for the return value
> >>>           times_ret = krsi_get_env_var(ctx, name, 48, map_value, 4096);
> >>>           ret = times_ret & 0xffffffff;
> >>>           if (ret < 0)
> >>>                   return ret;
> >>>           return 0;
> >>> }
> >>>
> >>> Signed-off-by: KP Singh <kpsingh@google.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h                  |  42 ++++++-
> >>>    security/krsi/ops.c                       | 129 ++++++++++++++++++++++
> >>>    tools/include/uapi/linux/bpf.h            |  42 ++++++-
> >>>    tools/testing/selftests/bpf/bpf_helpers.h |   3 +
> >>>    4 files changed, 214 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 32ab38f1a2fe..a4ef07956e07 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -2715,6 +2715,45 @@ union bpf_attr {
> >>>     *		**-EPERM** if no permission to send the *sig*.
> >>>     *
> >>>     *		**-EAGAIN** if bpf program can try again.
> >>> + *
> >>> + * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
> >>> + *			size_t name_len, size_t buf_len)
> >>
> >> This signature is not the same as the later
> >> krsi_get_env_var(...) helper definition.
> >> BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32,
> >> n_size,
> >> 	  char *, dest, u32, size)
> >>
> > 
> > I did this because the krsi_ctx is not exposed to the userspace and
> > allows KRSI to modify the context without worrying about breaking
> > userspace.
> > 
> > That said, I could mark it as a (void *) here and cast it internally.
> > I guess that would be better/cleaner?
> 
> "void *" is okay, I am complaining the argument ordering is different
> from real definition.

Ah, nice catch! Apologies for overlooking.

> 
> > 
> >>> + *	Description
> >>> + *		This helper can be used as a part of the
> >>> + *		process_execution hook of the KRSI LSM in
> >>> + *		programs of type BPF_PROG_TYPE_KRSI.
> >>> + *
> >>> + *		The helper returns the value of the environment
> >>> + *		variable with the provided "name" for process that's
> >>> + *		going to be executed in the passed buffer, "buf". If the var
> >>> + *		is set multiple times, the helper returns all
> >>> + *		the values as null separated strings.
> >>> + *
> >>> + *		If the buffer is too short for these values, the helper
> >>> + *		tries to fill it the best it can and guarantees that the value
> >>> + *		returned in the buffer  is always null terminated.
> >>> + *		After the buffer is filled, the helper keeps counting the number
> >>> + *		of times the environment variable is set in the envp.
> >>> + *
> >>> + *	Return:
> >>> + *
> >>> + *		The return value of the helper is an u64 value
> >>> + *		which carries two pieces of information:
> >>> + *
> >>> + *		   The upper 32 bits are a u32 value signifying
> >>> + *		   the number of times the environment variable
> >>> + *		   is set in the envp.
> >>> + *		   The lower 32 bits are an s32 value signifying
> >>> + *		   the number of bytes written to the buffer or an error code:
> >>> + *
> >>> + *		**-ENOMEM** if the kernel is unable to allocate memory
> >>> + *			    for pinning the argv and envv.
> >>> + *
> >>> + *		**-E2BIG** if the value is larger than the size of the
> >>> + *			   destination buffer. The higher bits will still
> >>> + *			   the number of times the variable was set in the envp.
> >>
> >> The -E2BIG is returned because buffer sizee is not big enough.
> >> Another possible error code is -ENOSPC, which typically indicates
> >> buffer size not big enough.
> > 
> > Sure, I am fine with using either.
> > 
> >>
> >>> + *
> >>> + *		**-EINVAL** if name is not a NULL terminated string.
> >>>     */
> >>>    #define __BPF_FUNC_MAPPER(FN)		\
> >>>    	FN(unspec),			\
> >>> @@ -2826,7 +2865,8 @@ union bpf_attr {
> >>>    	FN(strtoul),			\
> >>>    	FN(sk_storage_get),		\
> >>>    	FN(sk_storage_delete),		\
> >>> -	FN(send_signal),
> >>> +	FN(send_signal),		\
> >>> +	FN(krsi_get_env_var),
> >>>    
> >>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >>>     * function eBPF program intends to call
> >>> diff --git a/security/krsi/ops.c b/security/krsi/ops.c
> >>> index 1f4df920139c..1db94dfaac15 100644
> >>> --- a/security/krsi/ops.c
> >>> +++ b/security/krsi/ops.c
> >>> @@ -6,6 +6,8 @@
> >>>    #include <linux/bpf.h>
> >>>    #include <linux/security.h>
> >>>    #include <linux/krsi.h>
> >>> +#include <linux/binfmts.h>
> >>> +#include <linux/highmem.h>
> >>>    
> >>>    #include "krsi_init.h"
> >>>    #include "krsi_fs.h"
> >>> @@ -162,6 +164,131 @@ static bool krsi_prog_is_valid_access(int off, int size,
> >>>    	return false;
> >>>    }
> >>>    
> >>> +static char *array_next_entry(char *array, unsigned long *offset,
> >>> +			      unsigned long end)
> >>> +{
> >>> +	char *entry;
> >>> +	unsigned long current_offset = *offset;
> >>> +
> >>> +	if (current_offset >= end)
> >>> +		return NULL;
> >>> +
> >>> +	/*
> >>> +	 * iterate on the array till the null byte is encountered
> >>> +	 * and check for any overflows.
> >>> +	 */
> >>> +	entry = array + current_offset;
> >>> +	while (array[current_offset]) {
> >>> +		if (unlikely(++current_offset >= end))
> >>> +			return NULL;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * Point the offset to the next element in the array.
> >>> +	 */
> >>> +	*offset = current_offset + 1;
> >>> +
> >>> +	return entry;
> >>> +}
> >>> +
> >>> +static u64 get_env_var(struct krsi_ctx *ctx, char *name, char *dest,
> >>> +		u32 n_size, u32 size)
> >>> +{
> >>> +	s32 ret = 0;
> >>> +	u32 num_vars = 0;
> >>> +	int i, name_len;
> >>> +	struct linux_binprm *bprm = ctx->bprm_ctx.bprm;
> >>> +	int argc = bprm->argc;
> >>> +	int envc = bprm->envc;
> >>> +	unsigned long end = ctx->bprm_ctx.max_arg_offset;
> >>> +	unsigned long offset = bprm->p % PAGE_SIZE;
> >>
> >> why we need bprm->p % PAGE_SIZE instead of bprm->p?
> > 
> > bprm->p points to the top of the memory and it's not an offset.
> > 
> > The pinned buffer contains the pages for the (argv+env) and the
> > brpm->p % PAGE_SIZE is the offset into the first page where the
> > (argv+envv) starts.
> 
> Thanks for the explanation.
> 
> > 
> >>
> >>> +	char *buf = ctx->bprm_ctx.arg_pages;
> >>> +	char *curr_dest = dest;
> >>> +	char *entry;
> >>> +
> >>> +	if (unlikely(!buf))
> >>> +		return -ENOMEM;
> >>> +
> >>> +	for (i = 0; i < argc; i++) {
> >>> +		entry = array_next_entry(buf, &offset, end);
> >>> +		if (!entry)
> >>> +			return 0;
> >>> +	}
> >>> +
> >>> +	name_len = strlen(name);
> >>> +	for (i = 0; i < envc; i++) {
> >>> +		entry = array_next_entry(buf, &offset, end);
> >>> +		if (!entry)
> >>> +			return 0;
> >>
> >> If the buf is "LD_PRELOAD=a.so\0LD_PRELOAD=b.so" and argc=0,
> >> we may skip the first entry?
> > 
> > I think I need to rename the "array_next_entry" function / document it
> > better.
> > 
> > The function updates the offset to the next location and the
> > returns the entry at the current offset.
> > 
> > So, in the first instance:
> > 
> >     // offset is the offset into the first page.
> >     entry = buf + offset;
> >     offset = <updated value to the next entry>.
> 
> Yes, some documentation will help.
> 
> > 
> >>
> >>
> >>> +
> >>> +		if (!strncmp(entry, name, name_len)) {
> >>> +			num_vars++;
> >>
> >> There helper permits n_size = 0 (ARG_CONST_SIZE_OR_ZERO).
> >> in this case, name_len = 0, strncmp(entry, name, name_len) will be always 0.
> > 
> > Thanks, you are right, It does not make sense to have name_len = 0. I
> > will change it to ARG_CONST_SIZE.
> > 
> >>
> >>> +
> >>> +			/*
> >>> +			 * There is no need to do further copying
> >>> +			 * if the buffer is already full. Just count how many
> >>> +			 * times the environment variable is set.
> >>> +			 */
> >>> +			if (ret == -E2BIG)
> >>> +				continue;
> >>> +
> >>> +			if (entry[name_len] != '=')
> >>> +				continue;
> >>> +
> >>> +			/*
> >>> +			 * Move the buf pointer by name_len + 1
> >>> +			 * (for the "=" sign)
> >>> +			 */
> >>> +			entry += name_len + 1;
> >>> +			ret = strlcpy(curr_dest, entry, size);
> >>> +
> >>> +			if (ret >= size) {
> >>> +				ret = -E2BIG;
> >>
> >> Here, we have a partial copy. Should you instead nullify (memset) it as
> >> it is not really invalid one?
> > 
> > The function does specify that the it will return a null terminated
> > value even if an -E2BIG is returned so that user does get a truncated
> > value. It's better to give the user some data. (I mentioned this in
> > the documentation for the helper).
> 
> Do you know what user could do with this partial data?
> Again, I am not a security expert, maybe partial data can still
> be used in meaningful.

It's best to give the userspace as much data as possible and indicate an
overflow so that user-space can use this information to create more
context around the possible malicious activity.

- KP

> 
> > 
> >>
> >>> +				continue;
> >>> +			}
> >>> +
> >>> +			/*
> >>> +			 * strlcpy just returns the length of the string copied.
> >>> +			 * The remaining space needs to account for the added
> >>> +			 * null character.
> >>> +			 */
> >>> +			curr_dest += ret + 1;
> >>> +			size -= ret + 1;
> >>> +			/*
> >>> +			 * Update ret to be the current number of bytes written
> >>> +			 * to the destination
> >>> +			 */
> >>> +			ret = curr_dest - dest;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return (u64) num_vars << 32 | (u32) ret;
> >>> +}
> >>> +
> >>> +BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32, n_size,
> >>> +	  char *, dest, u32, size)
> >>> +{
> >>> +	char *name_end;
> >>> +
> >>> +	name_end = memchr(name, '\0', n_size);
> >>> +	if (!name_end)
> >>> +		return -EINVAL;
> >>> +
> >>> +	memset(dest, 0, size);
> > 
> > This memset ensures the buffer is zeroed out (incase the buffer is
> > fully / partially empty).
> > 
> >>> +	return get_env_var(ctx, name, dest, n_size, size);
> >>> +}
> >>> +
> >>> +static const struct bpf_func_proto krsi_get_env_var_proto = {
> >>> +	.func = krsi_get_env_var,
> >>> +	.gpl_only = true,
> >>> +	.ret_type = RET_INTEGER,
> >>> +	.arg1_type = ARG_PTR_TO_CTX,
> >>> +	.arg2_type = ARG_PTR_TO_MEM,
> >>> +	.arg3_type = ARG_CONST_SIZE_OR_ZERO,
> >>> +	.arg4_type = ARG_PTR_TO_UNINIT_MEM,
> >>> +	.arg5_type = ARG_CONST_SIZE_OR_ZERO,
> >>> +};
> >>> +
> >>>    BPF_CALL_5(krsi_event_output, void *, log,
> >>>    	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
> >>>    {
> >>> @@ -192,6 +319,8 @@ static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
> >>>    		return &bpf_map_lookup_elem_proto;
> >>>    	case BPF_FUNC_get_current_pid_tgid:
> >>>    		return &bpf_get_current_pid_tgid_proto;
> >>> +	case BPF_FUNC_krsi_get_env_var:
> >>> +		return &krsi_get_env_var_proto;
> >>>    	case BPF_FUNC_perf_event_output:
> >>>    		return &krsi_event_output_proto;
> >>>    	default:
> >>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> >>> index 32ab38f1a2fe..a4ef07956e07 100644
> >>> --- a/tools/include/uapi/linux/bpf.h
> >>> +++ b/tools/include/uapi/linux/bpf.h
> >>> @@ -2715,6 +2715,45 @@ union bpf_attr {
> >>>     *		**-EPERM** if no permission to send the *sig*.
> >>>     *
> >>>     *		**-EAGAIN** if bpf program can try again.
> >>> + *
> >>> + * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
> >>> + *			size_t name_len, size_t buf_len)
> >>
> >> Inconsistent helper definitions.
> > 
> > As discussed above, I can change the BPF_CALL_5 declaration to have
> > a (void *) and cast to the krsi_ctx in the helper itself.
> > 
> > - KP
> > 
> >>
> >>> + *	Description
> >>> + *		This helper can be used as a part of the
> >>> + *		process_execution hook of the KRSI LSM in
> >>> + *		programs of type BPF_PROG_TYPE_KRSI.
> >>> + *
> >>> + *		The helper returns the value of the environment
> >>> + *		variable with the provided "name" for process that's
> >>> + *		going to be executed in the passed buffer, "buf". If the var
> >>> + *		is set multiple times, the helper returns all
> >>> + *		the values as null separated strings.
> >>> + *
> >>> + *		If the buffer is too short for these values, the helper
> >>> + *		tries to fill it the best it can and guarantees that the value
> >>> + *		returned in the buffer  is always null terminated.
> >>> + *		After the buffer is filled, the helper keeps counting the number
> >>> + *		of times the environment variable is set in the envp.
> >>> + *
> >>> + *	Return:
> >>> + *
> >>> + *		The return value of the helper is an u64 value
> >>> + *		which carries two pieces of information:
> >>> + *
> >>> + *		   The upper 32 bits are a u32 value signifying
> >>> + *		   the number of times the environment variable
> >>> + *		   is set in the envp.
> >>> + *		   The lower 32 bits are an s32 value signifying
> >>> + *		   the number of bytes written to the buffer or an error code:
> >>> + *
> >>> + *		**-ENOMEM** if the kernel is unable to allocate memory
> >>> + *			    for pinning the argv and envv.
> >>> + *
> >>> + *		**-E2BIG** if the value is larger than the size of the
> >>> + *			   destination buffer. The higher bits will still
> >>> + *			   the number of times the variable was set in the envp.
> >>> + *
> >>> + *		**-EINVAL** if name is not a NULL terminated string.
> >>>     */
> >>>    #define __BPF_FUNC_MAPPER(FN)		\
> >>>    	FN(unspec),			\
> >>> @@ -2826,7 +2865,8 @@ union bpf_attr {
> >>>    	FN(strtoul),			\
> >>>    	FN(sk_storage_get),		\
> >>>    	FN(sk_storage_delete),		\
> >>> -	FN(send_signal),
> >>> +	FN(send_signal),		\
> >>> +	FN(krsi_get_env_var),
> >>>    
> >>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >>>     * function eBPF program intends to call
> >>> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> >>> index f804f210244e..ecebdb772a9d 100644
> >>> --- a/tools/testing/selftests/bpf/bpf_helpers.h
> >>> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> >>> @@ -303,6 +303,9 @@ static int (*bpf_get_numa_node_id)(void) =
> >>>    static int (*bpf_probe_read_str)(void *ctx, __u32 size,
> >>>    				 const void *unsafe_ptr) =
> >>>    	(void *) BPF_FUNC_probe_read_str;
> >>> +static unsigned long long (*krsi_get_env_var)(void *ctx,
> >>> +	void *name, __u32 n_size, void *buf, __u32 size) =
> >>> +	(void *) BPF_FUNC_krsi_get_env_var;
> >>>    static unsigned int (*bpf_get_socket_uid)(void *ctx) =
> >>>    	(void *) BPF_FUNC_get_socket_uid;
> >>>    static unsigned int (*bpf_set_hash)(void *ctx, __u32 hash) =
> >>>
