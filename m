Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14C66BE54
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjAPM4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 07:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjAPMzW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 07:55:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E63B1E5E1
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 04:53:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v30so40590090edb.9
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqAH+QgSq8QWs55wzm+pc8EhChV4O1p0rSLBedpXFP4=;
        b=XHNkaqXTHuRO2/tKeLAgzY9aE3GK/hhlH4p3X4kDMrVKwy1KBKONCX+fP1SC6KO1bG
         XdbK7GyPOxlixxtQozw0gKtCfuFmaRRUzrcx4QU56SCvQK/Hsw1xf4wN5u6iZXkuY0YN
         bRTI4Qor4Uty75bmffGgYaGsyNs6FVaMgpzZCYLrfeH7jzdF47s+f+SCgmw/Q2dqaDYf
         i09RYs2/i/jug/ubnUwemHaZ/crmBDtyTqaXy9urEfQMFJlblDCkP64Z6XrUo4OkW3+Q
         ukiP6xekY3FCZeVXidgiAifGdSFwkpi/Ea1O1y300xfyM5ZzvSuOt7W7YkYvaq4nBZFd
         S2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqAH+QgSq8QWs55wzm+pc8EhChV4O1p0rSLBedpXFP4=;
        b=smDWmNB96imWR4t/gvl7mIeZu3OXZnq/R9UiVIbXp2TIjiWucD4HrmGLA94Gn1WcxO
         O9DiWlryAU17kVKtFi7tp0qEa37unAuOpO8qPNRNKxV0Q4jpCw8Hb2FWDxKND0WFnDZw
         G9dMx8WGZNHsmtFV0m7nLRsYT2z0OFW+CVCIZrNVO6/I39MBNKlayjT+KHchgurjQoJA
         ZI1v6tvNC1hJzSbUeLUyEA5IroJIRjJUKQT5VKan++8BbSmfh2YH4IjFzfIUI8hfKqXJ
         TU/h7AoJ6tT/YRDYIpxC8XGNgHmjKXjZ4GjfaVcnDtqmfHlAP3kCK/tKxMT4lvlfUsni
         Tt+w==
X-Gm-Message-State: AFqh2kqGR++JNVZDePlbsRd4xQSe4oSjCNj1bm7naxpKK/jSv2SpoSHX
        xNBjK19+kpMhr4rZjQ1LsVQ=
X-Google-Smtp-Source: AMrXdXs/lySbxyg++f5Wf2clLU3uT+acDo+xQnGdsbKekGKka7SDb5CW6TxgjvlZWNGMHrY6jH4ucg==
X-Received: by 2002:a05:6402:4015:b0:46a:3bd0:4784 with SMTP id d21-20020a056402401500b0046a3bd04784mr89237295eda.7.1673873584792;
        Mon, 16 Jan 2023 04:53:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cx26-20020a05640222ba00b0048ec121a52fsm11484335edb.46.2023.01.16.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:53:04 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 16 Jan 2023 13:53:01 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
Message-ID: <Y8VIrddBlpVQ0K3v@krava>
References: <20230111101142.562765-1-jolsa@kernel.org>
 <CAADnVQJgwc3gjLa_Z5OxxW2g7dz0GtFk_aZpx55=k=LV-iiDDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJgwc3gjLa_Z5OxxW2g7dz0GtFk_aZpx55=k=LV-iiDDw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 15, 2023 at 01:21:48PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 11, 2023 at 2:11 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we allow to load any tracing program as sleepable,
> > but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
> > for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
> > will fail to load.
> >
> > Updating the verifier error to mention iter programs as well.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > v2 changes:
> >   - use bool for can_be_sleepable return value [Song]
> >   - add tests [Song]
> >
> >  kernel/bpf/verifier.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fa4c911603e9..f20777c2a957 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16743,6 +16743,18 @@ BTF_ID(func, rcu_read_unlock_strict)
> >  #endif
> >  BTF_SET_END(btf_id_deny)
> >
> > +static bool can_be_sleepable(struct bpf_prog *prog)
> > +{
> > +       if (prog->type == BPF_PROG_TYPE_TRACING) {
> > +               return prog->expected_attach_type == BPF_TRACE_FENTRY ||
> > +                      prog->expected_attach_type == BPF_TRACE_FEXIT ||
> > +                      prog->expected_attach_type == BPF_MODIFY_RETURN ||
> > +                      prog->expected_attach_type == BPF_TRACE_ITER;
> > +       }
> > +       return prog->type == BPF_PROG_TYPE_LSM ||
> > +              prog->type == BPF_PROG_TYPE_KPROBE;
> > +}
> 
> imo it's too verbose.
> Maybe try a switch stmt ?
> Or at least copy prog->expected_attach_type and prog->type into variables.

ok, the switch seems better, I'll send new version

thanks,
jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa4c911603e9..966dbfc14288 100644
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
+	       prog->type == BPF_PROG_TYPE_KPROBE;
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
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
 		return -EINVAL;
 	}
 
