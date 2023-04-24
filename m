Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44CB6ED79E
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 00:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjDXWLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjDXWLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 18:11:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04803100
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 15:11:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b70f0b320so6763297b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374284; x=1684966284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc5l4SZ96gOKJzfH6MqTWbJA8tlfHIOFteq/rNRSUt4=;
        b=eh6gnl0y8/pxO1m0EATZjEdi8bDnAqa2IK55/n+4DM7xMX+GwX8v78v2PWJ6IPcQAn
         vdGFGLlBfB1WfFsHq5m0AsuCow7sUgbYLq7ttlHQsIxLUBNJSVo78JMBE7vxnh76oXgd
         +ooOKjx6rWTtwh/MgdBsJNu3wMQIAV2rigyHQVAPV1gxEM+6qDvlInC7sIhcBdVyT8MP
         YD7Um0Q6n8Bfmq+PJkh5ho+HFRIcRRMPohEE8qh3p7og14p9s/bNQE93f+b8tlQK7pdp
         proaFMtakEIWteydwxqYQu6CiXWIr6iPbFZoc9IX/VjuEg4R2Sb8u3/qiLf9RIIZiUX7
         PfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374284; x=1684966284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc5l4SZ96gOKJzfH6MqTWbJA8tlfHIOFteq/rNRSUt4=;
        b=fxXSKXDST3jS2TAf4qjLzE+V2W3dzhapS6SubdEi3iQO740ao8iIKzSrBKh15PKi8k
         Ek4fkd2UYWCk2mOPViYyRGJUDJAjpz1lPHBxyiQpLzJoTs6SGYmc1/vciop9IdbQaV+U
         zpiSvfxQIsyoxp7704fSk9gOWL57/azm1YS/J6ri1kngsFCiU+6qAGgc4b2HTFBlmgI7
         +UXptaKT/74wBbi9zMxui50ZCxJdeAZSYF1Sl8JTnKcQkM85f22wdc5KQH/ODIHNbkJw
         lYnt6FBuZubFKPnezZHrdMWRBPpoVB7ShPUb2EVINMjh81DWQlpe6J3qVfdkZc3/VpFv
         9X6g==
X-Gm-Message-State: AAQBX9eUSRvWrlxPFj9+ICq7c6zn+LI/G9YS5YooIOli4SE0pGClbWvV
        h5ZzZ4A4b5yG39FP2Ip7M04=
X-Google-Smtp-Source: AKy350YvcYVvbrlVuFa3qK2uEmV/Q/7Nt8ff9gZxspbksyt2ny5UvY0kCTzl9w7B8dxPUjps9HgFrw==
X-Received: by 2002:a05:6a00:812:b0:63d:25e7:fd1b with SMTP id m18-20020a056a00081200b0063d25e7fd1bmr21897877pfk.14.1682374284266;
        Mon, 24 Apr 2023 15:11:24 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ef5e])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0063db25e140bsm7823862pfe.32.2023.04.24.15.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:11:23 -0700 (PDT)
Date:   Mon, 24 Apr 2023 15:11:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiri Olsa <jolsa@kernel.org>
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
Message-ID: <20230424221120.h3vdmuehxi33st4n@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424160447.2005755-2-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 06:04:28PM +0200, Jiri Olsa wrote:
> +
> +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> +			   unsigned long entry_ip,
> +			   struct pt_regs *regs)
> +{
> +	struct bpf_uprobe_multi_link *link = uprobe->link;
> +	struct bpf_uprobe_multi_run_ctx run_ctx = {
> +		.entry_ip = entry_ip,
> +	};
> +	struct bpf_run_ctx *old_run_ctx;
> +	int err;
> +
> +	preempt_disable();

preempt_disable? Which year is this? :)
Let's allow sleepable from the start.
See bpf_prog_run_array_sleepable.

Other than this the set looks great.

> +
> +	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	err = bpf_prog_run(link->link.prog, regs);
> +	bpf_reset_run_ctx(old_run_ctx);
> +	rcu_read_unlock();
> +
> + out:
> +	__this_cpu_dec(bpf_prog_active);
> +	preempt_enable();
> +	return err;
...
> +			struct path path;
> +			char *name;
> +
> +			name = strndup_user(upath, PATH_MAX);
> +			if (IS_ERR(name)) {
> +				err = PTR_ERR(name);
> +				goto error;
> +			}
> +			err = kern_path(name, LOOKUP_FOLLOW, &path);
> +			kfree(name);
> +			if (err)
> +				goto error;
> +			if (!d_is_reg(path.dentry)) {
> +				err = -EINVAL;
> +				path_put(&path);
> +				goto error;
> +			}
> +			inode = d_real_inode(path.dentry);
> +			path_put(&path);

inode won't disappear between here and its use in uprobe_register_refctr ?

> +		}
> +		old_upath = upath;
> +
> +		uprobes[i].inode = inode;
> +		uprobes[i].offset = offset;
> +		uprobes[i].ref_ctr_offset = ref_ctr_offset;
> +		uprobes[i].link = link;
> +
> +		if (flags & BPF_F_UPROBE_MULTI_RETURN)
> +			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
> +		else
> +			uprobes[i].consumer.handler = uprobe_multi_link_handler;
> +	}
> +
> +	link->cnt = cnt;
> +	link->uprobes = uprobes;
> +
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> +		      &bpf_uprobe_multi_link_lops, prog);
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err)
> +		goto error;
> +
> +	for (i = 0; i < cnt; i++) {
> +		err = uprobe_register_refctr(uprobes[i].inode, uprobes[i].offset,
> +					     uprobes[i].ref_ctr_offset,
> +					     &uprobes[i].consumer);
