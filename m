Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B80B3AE2
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfIPNAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 09:00:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40795 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfIPNAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 09:00:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so33016651edm.7
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ngy+M76X7h+soHET04lVNsGU4eKBi37asITtpQKCKNo=;
        b=gfGVg8LdyRisbx+BE9jPidvnk50uiCiKrT75MRH6/ZXeW9BCll5/zwy/Mefahmr41W
         IWubJbjCVrQDhaGUdlrFiC9ICs8xsjSoXW93+KFHZCQ6wSHv41MbMMbMCLdgSdYB8L4M
         CGgjGK0ztn/jbcOy/4Bm606nLXeyoohBJsLY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ngy+M76X7h+soHET04lVNsGU4eKBi37asITtpQKCKNo=;
        b=YG/N7UsBGGGJaq3YO/o4pBqUUodN6yQ5rhBxijVrAglZIwCL0dlXu7w+wC1394Kc83
         dhsiK4nhAkSNlWr/5YWzp98vtfmH57UygM9qdCs4JDf5eu/zlmjU7nhHJhgUl2lElMUV
         DLtq5+ZXz0oOh10YieSGrfkhJqdMGpVrICdmHkLyGgctGVBe5AtOSLe39mrVNzVfAyxB
         bGzaK8sIiTjmwRArVL8likG29mXYBQX+pUJB3pszs4LDZq1Z845j6v/seIUNVcWYh4cg
         DcjKeouaQUiYx3rMaIzSw/FUV5vZvtCOpMetKTPERpsKwBbj56FgyScjznEOgQydyupG
         kqsg==
X-Gm-Message-State: APjAAAV6jlVV9OL4fOQQM+fevU0pYRj7/Uxy9/C6+bPma3oUNwryTmZn
        emmDf7J6kB/b4yrt1wwYYNeulA==
X-Google-Smtp-Source: APXvYqzICXng4EEDKjHUHsPbFF7O41G0bAdyuGX/lVbG+HLXcnUORjUJrcJuEbxGAuY6xX5pEIxXcg==
X-Received: by 2002:a17:906:b298:: with SMTP id q24mr1930501ejz.168.1568638846155;
        Mon, 16 Sep 2019 06:00:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:202:7df4:abcf:6db2:95b5])
        by smtp.gmail.com with ESMTPSA id os27sm383913ejb.18.2019.09.16.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:00:45 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 16 Sep 2019 15:00:43 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190916130043.GA64010@google.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-13-kpsingh@chromium.org>
 <0a5386c9-3dbd-1ed8-d94c-d866c6369743@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5386c9-3dbd-1ed8-d94c-d866c6369743@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reviewing!

On 15-Sep 00:16, Yonghong Song wrote:
> 
> 
> On 9/10/19 12:55 PM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> This patch cannot apply cleanly.
> 
> -bash-4.4$ git apply ~/p12.txt
> error: patch failed: include/uapi/linux/bpf.h:2715
> error: include/uapi/linux/bpf.h: patch does not apply
> error: patch failed: tools/include/uapi/linux/bpf.h:2715
> error: tools/include/uapi/linux/bpf.h: patch does not apply
> -bash-4.4$

I am not sure why this is happening, I tried:

git clone \
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git && \
  cd linux-next && \
  git checkout -b review v5.3-rc6 && \
  wget -P /tmp https://lore.kernel.org/patchwork/series/410101/mbox && \
  git am /tmp/mbox

and it worked.

This seems to work too:

  patch -p1 < <file>.patch

Can you try with "git am" please?

> 
> > 
> > The helper returns the value of the environment variable in the buffer
> > that is passed to it. If the var is set multiple times, the helper
> > returns all the values as null separated strings.
> > 
> > If the buffer is too short for these values, the helper tries to fill it
> > the best it can and guarantees that the value returned in the buffer
> > is always null terminated. After the buffer is filled, the helper keeps
> > counting the number of times the environment variable is set in the
> > envp.
> > 
> > The return value of the helper is an u64 value which carries two pieces
> > of information.
> > 
> >    * The upper 32 bits are a u32 value signifying the number of times
> >      the environment variable is set in the envp.
> 
> Not sure how useful this 'upper 32' bit value is. What user expected to do?
> 
> Another option is to have upper 32 bits encode the required buffer size
> to hold all values. This may cause some kind of user space action, e.g.,
> to replace the program with new program with larger per cpu map value size?
> 

The upper 32-bit value is actually an important part of the LSM's MAC
policy. It allows the user to:

- Return an -EPERM when if the environment variable is set more than
  once.
- Log a warning (this is what we are doing in the example) so
  this is flagged as a potential malicious actor.

> >    * The lower 32 bits are a s32 value signifying the number of bytes
> >      written to the buffer or an error code. >
> > Since the value of the environment variable can be very long and exceed
> > what can be allocated on the BPF stack, a per-cpu array can be used
> > instead:
> > 
> > struct bpf_map_def SEC("maps") env_map = {
> >          .type = BPF_MAP_TYPE_PERCPU_ARRAY,
> >          .key_size = sizeof(u32),
> >          .value_size = 4096,
> >          .max_entries = 1,
> > };
> 
> Could you use use map definition with SEC(".maps")?

Sure, I added this example program in the commit message. Will update
it to be more canonical. Thanks!

> 
> > 
> > SEC("prgrm")
> > int bpf_prog1(void *ctx)
> > {
> >          u32 map_id = 0;
> >          u64 times_ret;
> >          s32 ret;
> >          char name[48] = "LD_PRELOAD";
> 
> Reverse Christmas tree coding style, here and other places?

Will happily fix it.

However, I did not find it mentioned in the style guide:

  https://www.kernel.org/doc/html/v4.10/process/coding-style.html
  https://elixir.bootlin.com/linux/v4.6/source/Documentation/CodingStyle

Is there one specific to BPF?


> 
> > 
> >          char *map_value = bpf_map_lookup_elem(&env_map, &map_id);
> >          if (!map_value)
> >                  return 0;
> > 
> >          // Read the lower 32 bits for the return value
> >          times_ret = krsi_get_env_var(ctx, name, 48, map_value, 4096);
> >          ret = times_ret & 0xffffffff;
> >          if (ret < 0)
> >                  return ret;
> >          return 0;
> > }
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >   include/uapi/linux/bpf.h                  |  42 ++++++-
> >   security/krsi/ops.c                       | 129 ++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h            |  42 ++++++-
> >   tools/testing/selftests/bpf/bpf_helpers.h |   3 +
> >   4 files changed, 214 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 32ab38f1a2fe..a4ef07956e07 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2715,6 +2715,45 @@ union bpf_attr {
> >    *		**-EPERM** if no permission to send the *sig*.
> >    *
> >    *		**-EAGAIN** if bpf program can try again.
> > + *
> > + * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
> > + *			size_t name_len, size_t buf_len)
> 
> This signature is not the same as the later
> krsi_get_env_var(...) helper definition.
> BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32, 
> n_size,
> 	  char *, dest, u32, size)
> 

I did this because the krsi_ctx is not exposed to the userspace and
allows KRSI to modify the context without worrying about breaking
userspace.

That said, I could mark it as a (void *) here and cast it internally.
I guess that would be better/cleaner?

> > + *	Description
> > + *		This helper can be used as a part of the
> > + *		process_execution hook of the KRSI LSM in
> > + *		programs of type BPF_PROG_TYPE_KRSI.
> > + *
> > + *		The helper returns the value of the environment
> > + *		variable with the provided "name" for process that's
> > + *		going to be executed in the passed buffer, "buf". If the var
> > + *		is set multiple times, the helper returns all
> > + *		the values as null separated strings.
> > + *
> > + *		If the buffer is too short for these values, the helper
> > + *		tries to fill it the best it can and guarantees that the value
> > + *		returned in the buffer  is always null terminated.
> > + *		After the buffer is filled, the helper keeps counting the number
> > + *		of times the environment variable is set in the envp.
> > + *
> > + *	Return:
> > + *
> > + *		The return value of the helper is an u64 value
> > + *		which carries two pieces of information:
> > + *
> > + *		   The upper 32 bits are a u32 value signifying
> > + *		   the number of times the environment variable
> > + *		   is set in the envp.
> > + *		   The lower 32 bits are an s32 value signifying
> > + *		   the number of bytes written to the buffer or an error code:
> > + *
> > + *		**-ENOMEM** if the kernel is unable to allocate memory
> > + *			    for pinning the argv and envv.
> > + *
> > + *		**-E2BIG** if the value is larger than the size of the
> > + *			   destination buffer. The higher bits will still
> > + *			   the number of times the variable was set in the envp.
> 
> The -E2BIG is returned because buffer sizee is not big enough.
> Another possible error code is -ENOSPC, which typically indicates
> buffer size not big enough.

Sure, I am fine with using either.

> 
> > + *
> > + *		**-EINVAL** if name is not a NULL terminated string.
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)		\
> >   	FN(unspec),			\
> > @@ -2826,7 +2865,8 @@ union bpf_attr {
> >   	FN(strtoul),			\
> >   	FN(sk_storage_get),		\
> >   	FN(sk_storage_delete),		\
> > -	FN(send_signal),
> > +	FN(send_signal),		\
> > +	FN(krsi_get_env_var),
> >   
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >    * function eBPF program intends to call
> > diff --git a/security/krsi/ops.c b/security/krsi/ops.c
> > index 1f4df920139c..1db94dfaac15 100644
> > --- a/security/krsi/ops.c
> > +++ b/security/krsi/ops.c
> > @@ -6,6 +6,8 @@
> >   #include <linux/bpf.h>
> >   #include <linux/security.h>
> >   #include <linux/krsi.h>
> > +#include <linux/binfmts.h>
> > +#include <linux/highmem.h>
> >   
> >   #include "krsi_init.h"
> >   #include "krsi_fs.h"
> > @@ -162,6 +164,131 @@ static bool krsi_prog_is_valid_access(int off, int size,
> >   	return false;
> >   }
> >   
> > +static char *array_next_entry(char *array, unsigned long *offset,
> > +			      unsigned long end)
> > +{
> > +	char *entry;
> > +	unsigned long current_offset = *offset;
> > +
> > +	if (current_offset >= end)
> > +		return NULL;
> > +
> > +	/*
> > +	 * iterate on the array till the null byte is encountered
> > +	 * and check for any overflows.
> > +	 */
> > +	entry = array + current_offset;
> > +	while (array[current_offset]) {
> > +		if (unlikely(++current_offset >= end))
> > +			return NULL;
> > +	}
> > +
> > +	/*
> > +	 * Point the offset to the next element in the array.
> > +	 */
> > +	*offset = current_offset + 1;
> > +
> > +	return entry;
> > +}
> > +
> > +static u64 get_env_var(struct krsi_ctx *ctx, char *name, char *dest,
> > +		u32 n_size, u32 size)
> > +{
> > +	s32 ret = 0;
> > +	u32 num_vars = 0;
> > +	int i, name_len;
> > +	struct linux_binprm *bprm = ctx->bprm_ctx.bprm;
> > +	int argc = bprm->argc;
> > +	int envc = bprm->envc;
> > +	unsigned long end = ctx->bprm_ctx.max_arg_offset;
> > +	unsigned long offset = bprm->p % PAGE_SIZE;
> 
> why we need bprm->p % PAGE_SIZE instead of bprm->p?

bprm->p points to the top of the memory and it's not an offset.

The pinned buffer contains the pages for the (argv+env) and the
brpm->p % PAGE_SIZE is the offset into the first page where the
(argv+envv) starts.

> 
> > +	char *buf = ctx->bprm_ctx.arg_pages;
> > +	char *curr_dest = dest;
> > +	char *entry;
> > +
> > +	if (unlikely(!buf))
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < argc; i++) {
> > +		entry = array_next_entry(buf, &offset, end);
> > +		if (!entry)
> > +			return 0;
> > +	}
> > +
> > +	name_len = strlen(name);
> > +	for (i = 0; i < envc; i++) {
> > +		entry = array_next_entry(buf, &offset, end);
> > +		if (!entry)
> > +			return 0;
> 
> If the buf is "LD_PRELOAD=a.so\0LD_PRELOAD=b.so" and argc=0,
> we may skip the first entry?

I think I need to rename the "array_next_entry" function / document it
better.

The function updates the offset to the next location and the
returns the entry at the current offset.

So, in the first instance:

   // offset is the offset into the first page.
   entry = buf + offset;
   offset = <updated value to the next entry>.

> 
> 
> > +
> > +		if (!strncmp(entry, name, name_len)) {
> > +			num_vars++;
> 
> There helper permits n_size = 0 (ARG_CONST_SIZE_OR_ZERO).
> in this case, name_len = 0, strncmp(entry, name, name_len) will be always 0.

Thanks, you are right, It does not make sense to have name_len = 0. I
will change it to ARG_CONST_SIZE.

> 
> > +
> > +			/*
> > +			 * There is no need to do further copying
> > +			 * if the buffer is already full. Just count how many
> > +			 * times the environment variable is set.
> > +			 */
> > +			if (ret == -E2BIG)
> > +				continue;
> > +
> > +			if (entry[name_len] != '=')
> > +				continue;
> > +
> > +			/*
> > +			 * Move the buf pointer by name_len + 1
> > +			 * (for the "=" sign)
> > +			 */
> > +			entry += name_len + 1;
> > +			ret = strlcpy(curr_dest, entry, size);
> > +
> > +			if (ret >= size) {
> > +				ret = -E2BIG;
> 
> Here, we have a partial copy. Should you instead nullify (memset) it as 
> it is not really invalid one?

The function does specify that the it will return a null terminated
value even if an -E2BIG is returned so that user does get a truncated
value. It's better to give the user some data. (I mentioned this in
the documentation for the helper).

> 
> > +				continue;
> > +			}
> > +
> > +			/*
> > +			 * strlcpy just returns the length of the string copied.
> > +			 * The remaining space needs to account for the added
> > +			 * null character.
> > +			 */
> > +			curr_dest += ret + 1;
> > +			size -= ret + 1;
> > +			/*
> > +			 * Update ret to be the current number of bytes written
> > +			 * to the destination
> > +			 */
> > +			ret = curr_dest - dest;
> > +		}
> > +	}
> > +
> > +	return (u64) num_vars << 32 | (u32) ret;
> > +}
> > +
> > +BPF_CALL_5(krsi_get_env_var, struct krsi_ctx *, ctx, char *, name, u32, n_size,
> > +	  char *, dest, u32, size)
> > +{
> > +	char *name_end;
> > +
> > +	name_end = memchr(name, '\0', n_size);
> > +	if (!name_end)
> > +		return -EINVAL;
> > +
> > +	memset(dest, 0, size);

This memset ensures the buffer is zeroed out (incase the buffer is
fully / partially empty).

> > +	return get_env_var(ctx, name, dest, n_size, size);
> > +}
> > +
> > +static const struct bpf_func_proto krsi_get_env_var_proto = {
> > +	.func = krsi_get_env_var,
> > +	.gpl_only = true,
> > +	.ret_type = RET_INTEGER,
> > +	.arg1_type = ARG_PTR_TO_CTX,
> > +	.arg2_type = ARG_PTR_TO_MEM,
> > +	.arg3_type = ARG_CONST_SIZE_OR_ZERO,
> > +	.arg4_type = ARG_PTR_TO_UNINIT_MEM,
> > +	.arg5_type = ARG_CONST_SIZE_OR_ZERO,
> > +};
> > +
> >   BPF_CALL_5(krsi_event_output, void *, log,
> >   	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
> >   {
> > @@ -192,6 +319,8 @@ static const struct bpf_func_proto *krsi_prog_func_proto(enum bpf_func_id
> >   		return &bpf_map_lookup_elem_proto;
> >   	case BPF_FUNC_get_current_pid_tgid:
> >   		return &bpf_get_current_pid_tgid_proto;
> > +	case BPF_FUNC_krsi_get_env_var:
> > +		return &krsi_get_env_var_proto;
> >   	case BPF_FUNC_perf_event_output:
> >   		return &krsi_event_output_proto;
> >   	default:
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 32ab38f1a2fe..a4ef07956e07 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -2715,6 +2715,45 @@ union bpf_attr {
> >    *		**-EPERM** if no permission to send the *sig*.
> >    *
> >    *		**-EAGAIN** if bpf program can try again.
> > + *
> > + * u64 krsi_get_env_var(void *ctx, char *name, char *buf,
> > + *			size_t name_len, size_t buf_len)
> 
> Inconsistent helper definitions.

As discussed above, I can change the BPF_CALL_5 declaration to have
a (void *) and cast to the krsi_ctx in the helper itself.

- KP

> 
> > + *	Description
> > + *		This helper can be used as a part of the
> > + *		process_execution hook of the KRSI LSM in
> > + *		programs of type BPF_PROG_TYPE_KRSI.
> > + *
> > + *		The helper returns the value of the environment
> > + *		variable with the provided "name" for process that's
> > + *		going to be executed in the passed buffer, "buf". If the var
> > + *		is set multiple times, the helper returns all
> > + *		the values as null separated strings.
> > + *
> > + *		If the buffer is too short for these values, the helper
> > + *		tries to fill it the best it can and guarantees that the value
> > + *		returned in the buffer  is always null terminated.
> > + *		After the buffer is filled, the helper keeps counting the number
> > + *		of times the environment variable is set in the envp.
> > + *
> > + *	Return:
> > + *
> > + *		The return value of the helper is an u64 value
> > + *		which carries two pieces of information:
> > + *
> > + *		   The upper 32 bits are a u32 value signifying
> > + *		   the number of times the environment variable
> > + *		   is set in the envp.
> > + *		   The lower 32 bits are an s32 value signifying
> > + *		   the number of bytes written to the buffer or an error code:
> > + *
> > + *		**-ENOMEM** if the kernel is unable to allocate memory
> > + *			    for pinning the argv and envv.
> > + *
> > + *		**-E2BIG** if the value is larger than the size of the
> > + *			   destination buffer. The higher bits will still
> > + *			   the number of times the variable was set in the envp.
> > + *
> > + *		**-EINVAL** if name is not a NULL terminated string.
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)		\
> >   	FN(unspec),			\
> > @@ -2826,7 +2865,8 @@ union bpf_attr {
> >   	FN(strtoul),			\
> >   	FN(sk_storage_get),		\
> >   	FN(sk_storage_delete),		\
> > -	FN(send_signal),
> > +	FN(send_signal),		\
> > +	FN(krsi_get_env_var),
> >   
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >    * function eBPF program intends to call
> > diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> > index f804f210244e..ecebdb772a9d 100644
> > --- a/tools/testing/selftests/bpf/bpf_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> > @@ -303,6 +303,9 @@ static int (*bpf_get_numa_node_id)(void) =
> >   static int (*bpf_probe_read_str)(void *ctx, __u32 size,
> >   				 const void *unsafe_ptr) =
> >   	(void *) BPF_FUNC_probe_read_str;
> > +static unsigned long long (*krsi_get_env_var)(void *ctx,
> > +	void *name, __u32 n_size, void *buf, __u32 size) =
> > +	(void *) BPF_FUNC_krsi_get_env_var;
> >   static unsigned int (*bpf_get_socket_uid)(void *ctx) =
> >   	(void *) BPF_FUNC_get_socket_uid;
> >   static unsigned int (*bpf_set_hash)(void *ctx, __u32 hash) =
> > 
