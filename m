Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC96EDFC2
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjDYJzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjDYJzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 05:55:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06D65BD
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 02:55:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so107632185e9.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682416500; x=1685008500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+liLxnvBjwItkO3vuKY6Kfr9tdx/kDpkknyq1m5SdYQ=;
        b=PnQO0Y0HXBj3PHMkR0EhVufqe102DLW1bR4rTevh2lApWDNfHISqi1fPg3hWPl3rsf
         eZJy52cDE9PlvSbJIkZoDeNNBMDuLKuBCplviWtMleKudqFG4p0gM2sTKDkNauo28H/G
         kTIyurr4vdBSRS1gMW6G13dEjdqCNDoXY+2o7U8O47n9ra4OhPEKvCihLolMVmZmUNfG
         Pq3vzt42GeikRDClcmTvk6gI9Vp+dtv/4GUW8MoeTe2JAHF4LbYUH7Jhv4Rnt1GW5d6R
         b0ysBwmEsJ6jjtN6BmX2gugV48xWjDyxR/1a5SWdXeSpn1xPpKF3LZpMHMDjWRcKe3i2
         r2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682416500; x=1685008500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+liLxnvBjwItkO3vuKY6Kfr9tdx/kDpkknyq1m5SdYQ=;
        b=DLBwOGST3xpKvyP90ni8cytSdEYfcmpdDflpO1OZp1hv1ClGJ+TUGvVuq2+doO3vDv
         DsW4BZWm12/fVhqbb/6gW7RDm1cQy0sn/kCF2VxSOo3dzxDIo9ndYtzv3Jk8qJ2z4PZK
         IPRIqP5pc1I2T0WDpB0peFfkwTtQQW/PiDwgtDvx36QROYFwk+0sfRSVi/wNDKp9fcuQ
         MkZuTnIFu4QymwmbYZMEpeNJCtIHMltvj0U1FX8RYM6Zj7PW/UENQMgXg6q7Ttvq+FL3
         xBYcTxgphCSM4qh5FoIEJT0TR+p2XN5TpEftAKKYeN15F1eXjGJDZfOXWN+Xp4K5S1XU
         Yc7A==
X-Gm-Message-State: AAQBX9fhAztYBUUixoxT3Wxg6jkoDaB0iFPti9i1CTow+ZmJQqc3aJVp
        cHtQqjNdf3VtRtHRT7lQBuc=
X-Google-Smtp-Source: AKy350Y81eNuibYw34cIiLTnzfcFBV/CF5oClwaIh2yk9lMbttzTWumtssyZ83k4orqjQgxEJNh3aA==
X-Received: by 2002:a5d:4c4e:0:b0:2f6:1a6d:a6c3 with SMTP id n14-20020a5d4c4e000000b002f61a6da6c3mr16137161wrt.21.1682416499573;
        Tue, 25 Apr 2023 02:54:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003ef4cd057f5sm18204308wmp.4.2023.04.25.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 02:54:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 25 Apr 2023 11:54:57 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Message-ID: <ZEejcYDRbxDGebAr@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
 <20230424221120.h3vdmuehxi33st4n@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424221120.h3vdmuehxi33st4n@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 03:11:20PM -0700, Alexei Starovoitov wrote:
> On Mon, Apr 24, 2023 at 06:04:28PM +0200, Jiri Olsa wrote:
> > +
> > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > +			   unsigned long entry_ip,
> > +			   struct pt_regs *regs)
> > +{
> > +	struct bpf_uprobe_multi_link *link = uprobe->link;
> > +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> > +		.entry_ip = entry_ip,
> > +	};
> > +	struct bpf_run_ctx *old_run_ctx;
> > +	int err;
> > +
> > +	preempt_disable();
> 
> preempt_disable? Which year is this? :)
> Let's allow sleepable from the start.
> See bpf_prog_run_array_sleepable.

ok, we should probably add also 'multi.uprobe.s' section so the program
gets loaded with the BPF_F_SLEEPABLE flag.. or maybe we can enable that
by default for 'multi.uprobe' section

> 
> Other than this the set looks great.
> 
> > +
> > +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > +		err = 0;
> > +		goto out;
> > +	}
> > +
> > +	rcu_read_lock();
> > +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +	err = bpf_prog_run(link->link.prog, regs);
> > +	bpf_reset_run_ctx(old_run_ctx);
> > +	rcu_read_unlock();
> > +
> > + out:
> > +	__this_cpu_dec(bpf_prog_active);
> > +	preempt_enable();
> > +	return err;
> ...
> > +			struct path path;
> > +			char *name;
> > +
> > +			name = strndup_user(upath, PATH_MAX);
> > +			if (IS_ERR(name)) {
> > +				err = PTR_ERR(name);
> > +				goto error;
> > +			}
> > +			err = kern_path(name, LOOKUP_FOLLOW, &path);
> > +			kfree(name);
> > +			if (err)
> > +				goto error;
> > +			if (!d_is_reg(path.dentry)) {
> > +				err = -EINVAL;
> > +				path_put(&path);
> > +				goto error;
> > +			}
> > +			inode = d_real_inode(path.dentry);
> > +			path_put(&path);
> 
> inode won't disappear between here and its use in uprobe_register_refctr ?

ugh, that's bug.. will fix

thanks,
jirka

> 
> > +		}
> > +		old_upath = upath;
> > +
> > +		uprobes[i].inode = inode;
> > +		uprobes[i].offset = offset;
> > +		uprobes[i].ref_ctr_offset = ref_ctr_offset;
> > +		uprobes[i].link = link;
> > +
> > +		if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > +			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
> > +		else
> > +			uprobes[i].consumer.handler = uprobe_multi_link_handler;
> > +	}
> > +
> > +	link->cnt = cnt;
> > +	link->uprobes = uprobes;
> > +
> > +	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > +		      &bpf_uprobe_multi_link_lops, prog);
> > +
> > +	err = bpf_link_prime(&link->link, &link_primer);
> > +	if (err)
> > +		goto error;
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		err = uprobe_register_refctr(uprobes[i].inode, uprobes[i].offset,
> > +					     uprobes[i].ref_ctr_offset,
> > +					     &uprobes[i].consumer);
