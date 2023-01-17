Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8966D9BE
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjAQJYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 04:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjAQJXp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 04:23:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57E241CB
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 01:20:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4018967wms.3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtLZI4l9M0sVHDpIaH2H830skcHso01sGuWkkQFZgCg=;
        b=Djaz9JvIj8oosA/ifPxZzRy9NX3e9BzwIg1MPi0GwnCNsBXZiUmrvIId1d5VIEDN5d
         8gjXVB5As7irvVOVv7O2w8DqjXSXaQwUAfJdyKAHdGfxpja+PPhRhHpftgTFM41rFd4d
         5pqgfdgcN06yltvVxEQoUpwkhy680wh7m+0CdNGfyAjNQ/U2H50LTnA3ckZAOKn76ZX8
         mqHFh9JDIQMfQGg/iHvauWSFL3cVXO25QAh23bVSvURjjdvCk293r3M9xywwr+0dXzfX
         A51gWB2RRV4QO6kY6nkJ5ujLKpAFH4Nzuq+wouHbKhqCtcUkSeNQEUMsWZ2YrNn1Bsmj
         hFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtLZI4l9M0sVHDpIaH2H830skcHso01sGuWkkQFZgCg=;
        b=VTKb5X4XN7mfYEJWlsGzFvkDK6P60n1ApRLY9neqwb/RB8VIN9b2WqGJwkwxycg8rh
         kCrYgCyl3WGxAYTQiwx9B+M6CZcNPSLm7RKwuqyP69hKHE1+Fko2n009tcUOzKOEwGNd
         lVIFhDHUuqW6s2KkKD9aLs7MPre4hToqEzEbOShOd9wAKyiStSoojDkUnvIo/EJydXp5
         /JVl6AqCeks39q8ZTkFC5QsozyMR5ZyjyFbHa1xB7qjW90L028WC6kkn7PHmFgKaK0qT
         MtRTjAtwQDgSFkjJAbcfNiDFmVbQyxGTS8DrL5xtqA2Gu2wrlVu18Y3tH7VvNkDivEs0
         ggKg==
X-Gm-Message-State: AFqh2kps6XKup3LoxMoJVpd3mtgr7/+uD9rQGfUeOwJgIWM3EpPekflZ
        c9lKX2stMlXgiMgwLuxJQ9s=
X-Google-Smtp-Source: AMrXdXsRBfNBk+jwvst7kpgkEIgYdwhI8yF/I48TXqeHmjpSnpyotDb20pdnVNLHebvvNSX0rgyS8w==
X-Received: by 2002:a05:600c:ac7:b0:3cf:9ac8:c537 with SMTP id c7-20020a05600c0ac700b003cf9ac8c537mr10976726wmr.14.1673947223525;
        Tue, 17 Jan 2023 01:20:23 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003db0cab0844sm282158wms.40.2023.01.17.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:20:23 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 17 Jan 2023 10:20:20 +0100
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
Message-ID: <Y8ZoVLIkqKeP3DnX@krava>
References: <20230116132901.161494-1-jolsa@kernel.org>
 <37b0ea1f-0c28-2858-550f-27f89563e588@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b0ea1f-0c28-2858-550f-27f89563e588@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 11:17:56PM -0800, Yonghong Song wrote:
> 
> 
> On 1/16/23 5:29 AM, Jiri Olsa wrote:
> > Currently we allow to load any tracing program as sleepable,
> > but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> > for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> > will fail to load.
> > 
> > Updating the verifier error to mention iter programs as well.
> > 
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Ack with a minor comment below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> > v3 changes:
> >    - use switch in can_be_sleepable [Alexei]
> >    - added acks [Song]
> > 
> >   kernel/bpf/verifier.c | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fa4c911603e9..966dbfc14288 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
> >   #endif
> >   BTF_SET_END(btf_id_deny)
> > +static bool can_be_sleepable(struct bpf_prog *prog)
> > +{
> > +	if (prog->type == BPF_PROG_TYPE_TRACING) {
> > +		switch (prog->expected_attach_type) {
> > +		case BPF_TRACE_FENTRY:
> > +		case BPF_TRACE_FEXIT:
> > +		case BPF_MODIFY_RETURN:
> > +		case BPF_TRACE_ITER:
> > +			return true;
> > +		default:
> > +			return false;
> > +		}
> > +	}
> > +	return prog->type == BPF_PROG_TYPE_LSM ||
> > +	       prog->type == BPF_PROG_TYPE_KPROBE;
> > +}
> > +
> >   static int check_attach_btf_id(struct bpf_verifier_env *env)
> >   {
> >   	struct bpf_prog *prog = env->prog;
> > @@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >   		return -EINVAL;
> >   	}
> > -	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> > -	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> > -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> > +	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> > +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
> 
> actually kprobe programs cannot be sleepable. See kernel/events/core.c.
> perf_event_set_bpf_prog(...)
> ...
> 
>         if (prog->type == BPF_PROG_TYPE_KPROBE && prog->aux->sleepable &&
> !is_uprobe)
>                 /* only uprobe programs are allowed to be sleepable */
>                 return -EINVAL;
> 
> So I suggest to add a comment and remove the above 'kprobe' from error
> message.

ok, is comment below ok?

jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..ca7db2ce70b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
 #endif
 BTF_SET_END(btf_id_deny)
 
+static bool can_be_sleepable(struct bpf_prog *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_TRACING) {
+		switch (prog->expected_attach_type) {
+		case BPF_TRACE_FENTRY:
+		case BPF_TRACE_FEXIT:
+		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_ITER:
+			return true;
+		default:
+			return false;
+		}
+	}
+	return prog->type == BPF_PROG_TYPE_LSM ||
+	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
+}
+
 static int check_attach_btf_id(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
@@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
+	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
 		return -EINVAL;
 	}
 
