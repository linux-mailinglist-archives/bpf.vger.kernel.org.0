Return-Path: <bpf+bounces-1754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169D720D03
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 03:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16646281B4C
	for <lists+bpf@lfdr.de>; Sat,  3 Jun 2023 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821C185D;
	Sat,  3 Jun 2023 01:32:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C413816
	for <bpf@vger.kernel.org>; Sat,  3 Jun 2023 01:32:15 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88718D
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 18:32:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so1558738a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685755933; x=1688347933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P2zYhIgiG5QVeJRMC9AaPeuQnm90z1jI3S+SIGbKu8=;
        b=tLk/Ps6vhMuiExVzI0hFwvqRkDt+QhCb1NIGsW7imqORzoMNC3rUUbo5yIeFcLo9q1
         sqd6hwpoRYRl+feL2ZDeedYkFrB6Tulhde2Quy2Tp7sybiVlVtK2PcZn+aL3PCq3vC33
         WgRGmLF6gj7yMOyCxiwcYsmdPR05n2cG8AMcOlpkBDr9GM9p837wn7OZBuR6fvW60165
         fksUSYSWBhPyM9U/6z4yB3SfldKi3VjnTJ+VSX26yZeTHjW+TR7qnQPlSi0RVG5JrKL9
         zYJgl8KzmGNRsHanvyu6S4Ehk2wBliNym0zUjNjhwCOtDX8AGEmTINlkUAeLPsEFkJ81
         Z4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755933; x=1688347933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P2zYhIgiG5QVeJRMC9AaPeuQnm90z1jI3S+SIGbKu8=;
        b=ZBJm4NxRwzvo0AkRIXQTM1BfdfNIZMfXFWfbLgzoXYE/8h5GiIEakTvCaOmAdz9yRp
         i8wwMk5J2CRwQX7lBJIDWfrHA7nNRtG3pjkigkuqA43YZ1OziFdhERRZ7GTDopB96PI6
         9aExkX0VxaY6vCCaZhQGdHk6c5S3i91DKi7f9nV33xzr+qO4WUOY7lEmEh+g1KXB0Itc
         lTEaaCOuWDmP9CPljxaT6GwwCLiHZlyC3rvgpRn+ikB4+HFS9GOoqTlpTPpdO1a5Hnm1
         ognd+mUQ6IPInlKaIovG9qzB6I3IuAA5VKbQccwM55CJCOjzUgWZ4c0sm4C7ZcOI8BHY
         a8Rw==
X-Gm-Message-State: AC+VfDxmD92u0PpbsfY0D+NehlLIhXTikHmNOrmzoOdPUyvRCZHx8YKd
	ZC5bjyM7QbiqUPisSHBgwXstUNM=
X-Google-Smtp-Source: ACHHUZ6WBX989vx15nCw3ucm0hcWhDiiypVgXJyFq+fktqceAS2mVzdZLH3y2Auf3eUGS9bdzl8F19U=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:6956:0:b0:521:3c29:6055 with SMTP id
 w22-20020a656956000000b005213c296055mr1391989pgq.6.1685755933524; Fri, 02 Jun
 2023 18:32:13 -0700 (PDT)
Date: Fri, 2 Jun 2023 18:32:11 -0700
In-Reply-To: <20230602150011.1657856-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230602150011.1657856-1-andrii@kernel.org> <20230602150011.1657856-2-andrii@kernel.org>
Message-ID: <ZHqYG3q34nnt99pM@google.com>
Subject: Re: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	cyphar@cyphar.com, luto@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/02, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operation could be done using provided BPF token.
> 
> This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
> allows to create a new BPF token object along with a set of allowed
> commands. Currently only BPF_TOKEN_CREATE command itself can be
> delegated, but other patches gradually add ability to delegate
> BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
> 
> The above means that BPF token creation can be allowed by another
> existing BPF token, if original privileged creator allowed that. New
> derived BPF token cannot be more powerful than the original BPF token.
> 
> BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS flag is added to allow application to do
> express "all supported BPF commands should be allowed" without worrying
> about which subset of desired commands is actually supported by
> potentially outdated kernel. Allowing this semantics doesn't seem to
> introduce any backwards compatibility issues and doesn't introduce any
> risk of abusing or misusing bit set field, but makes backwards
> compatibility story for various applications and tools much more
> straightforward, making it unnecessary to probe support for each
> individual possible bit. This is especially useful in follow up patches
> where we add BPF map types and prog types bit sets.
> 
> Lastly, BPF token can be pinned in and retrieved from BPF FS, just like
> progs, maps, BTFs, and links. This allows applications (like container
> managers) to share BPF token with other applications through file system
> just like any other BPF object, and further control access to it using
> file system permissions, if desired.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  34 +++++++++
>  include/uapi/linux/bpf.h       |  42 ++++++++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |  26 +++++++
>  kernel/bpf/syscall.c           |  74 ++++++++++++++++++++
>  kernel/bpf/token.c             | 122 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  40 +++++++++++
>  7 files changed, 339 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/token.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..fe6d51c3a5b1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -51,6 +51,7 @@ struct module;
>  struct bpf_func_state;
>  struct ftrace_ops;
>  struct cgroup;
> +struct bpf_token;
>  
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -1533,6 +1534,12 @@ struct bpf_link_primer {
>  	u32 id;
>  };
>  
> +struct bpf_token {
> +	struct work_struct work;
> +	atomic64_t refcnt;
> +	u64 allowed_cmds;
> +};
> +
>  struct bpf_struct_ops_value;
>  struct btf_member;
>  
> @@ -2077,6 +2084,15 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>  
> +void bpf_token_inc(struct bpf_token *token);
> +void bpf_token_put(struct bpf_token *token);
> +struct bpf_token *bpf_token_alloc(void);
> +int bpf_token_new_fd(struct bpf_token *token);
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd);
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap);
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
> +
>  int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
>  int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
>  
> @@ -2436,6 +2452,24 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline void bpf_token_inc(struct bpf_token *token)
> +{
> +}
> +
> +static inline void bpf_token_put(struct bpf_token *token)
> +{
> +}
> +
> +static inline struct bpf_token *bpf_token_new_fd(struct bpf_token *token)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline void __dev_flush(void)
>  {
>  }
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 9273c654743c..01ab79f2ad9f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -846,6 +846,16 @@ union bpf_iter_link_info {
>   *		Returns zero on success. On error, -1 is returned and *errno*
>   *		is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *	Description
> + *		Create BPF token with embedded information about what
> + *		BPF-related functionality is allowed. This BPF token can be
> + *		passed as an extra parameter to various bpf() syscall command.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
>   * NOTES
>   *	eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -900,6 +910,7 @@ enum bpf_cmd {
>  	BPF_ITER_CREATE,
>  	BPF_LINK_DETACH,
>  	BPF_PROG_BIND_MAP,
> +	BPF_TOKEN_CREATE,
>  };
>  
>  enum bpf_map_type {
> @@ -1169,6 +1180,24 @@ enum bpf_link_type {
>   */
>  #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
>  
> +/* BPF_TOKEN_CREATE command flags
> + */
> +enum {
> +	/* Ignore unrecognized bits in token_create.allowed_cmds bit set.  If
> +	 * this flag is set, kernel won't return -EINVAL for a bit
> +	 * corresponding to a non-existing command or the one that doesn't
> +	 * support BPF token passing. This flags allows application to request
> +	 * BPF token creation for a desired set of commands without worrying
> +	 * about older kernels not supporting some of the commands.
> +	 * Presumably, deployed applications will do separate feature
> +	 * detection and will avoid calling not-yet-supported bpf() commands,
> +	 * so this BPF token will work equally well both on older and newer
> +	 * kernels, even if some of the requested commands won't be BPF
> +	 * token-enabled.
> +	 */
> +	BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS		  = 1U << 0,
> +};
> +
>  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
>   * the following extensions:
>   *
> @@ -1621,6 +1650,19 @@ union bpf_attr {
>  		__u32		flags;		/* extra flags */
>  	} prog_bind_map;
>  
> +	struct { /* struct used by BPF_TOKEN_CREATE command */
> +		__u32		flags;
> +		__u32		token_fd;
> +		/* a bit set of allowed bpf() syscall commands,
> +		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
> +		 * will allow creating derived BPF tokens and loading new BPF
> +		 * programs;
> +		 * see also BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS for its effect on
> +		 * validity checking of this set
> +		 */
> +		__u64		allowed_cmds;
> +	} token_create;

Do you think this might eventually grow into something like
"allow only lookup operation for this specific map"? If yes, maybe it
makes sense to separate token-create vs token-add-capability operations?

BPF_TOKEN_CREATE would create a token that can't do anything. Then you
would call a bunch of BPF_TOKEN_ALLOW with maybe op=SYSCALL_CMD
value=BPF_TOKEN_CREATE.

This will be more future-proof plus won't really depend on having a
bitmask in the uapi. Then the users will be able to handle
BPF_TOKEN_ALLOW{op=SYSCALL_CMD value=SOME_VALUE_NOT_SUPPORTED_ON_THIS_KERNEL}
themselves (IOW, BPF_F_TOKEN_IGNORE_UNKNOWN_CMDS won't be needed).

