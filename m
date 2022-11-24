Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D32638036
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 21:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKXUen (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 15:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXUem (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 15:34:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6FB7006
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 12:34:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3837633edb.9
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 12:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnJgD/q3BwY5G7Z6IfRNznHqFqimnlrhC1OYvh3pVYI=;
        b=AAZ32mdkOeS2fIVyFgW40a3Q+WSHTXrwjqgTWzodRElJ2ffZ8z31jJDU8KPlJCLgtl
         gnMiIvM8M/kyJDUnlg8FlICUBnSDGFJ/qwYUulTWkSRC23fjaKY+OCuFzJCxuONUaPR3
         t8ixImKl0ssxw39uaeX1xRXbudZh3yIhK0MRSTOOfyK2xMUsDf/JXMj4vwdtpcmmUXO4
         4IiJ2Jy47YJONjf7M6Pd2fUQdod3XtWUKNqKjXclmNhO9TpD+VnBsnH4b3Kft15GadBH
         sFQ8lrYZ2pzcS5OFyy0qrtw7dZ4k63ayzh3TFFLtD943N6WRMUM2hoXhsRNUTYvIuqkk
         46mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnJgD/q3BwY5G7Z6IfRNznHqFqimnlrhC1OYvh3pVYI=;
        b=uk7tM6Kh6cG/FpUf3IuIgfb5hK4LAvr41WBsaUjW3Byu4PAmaxes2+D8Etpx7g+XKh
         YT1rZG13SXEYf3ftsm+VjZOYYpT7jULEZkN7t9swSMwo77q+r1yirkwzvur3nRmIGiOk
         fnoT3ok0A5JGX6hErOaX7h663JCCGgZ5Ss1jdVNd7h/j+XNg80IZwCIrgp7ZGR4keXm+
         RI054HpFa/OG4gXJc/yJ8Ri80NnqRJxe+2Q5+h+6crzwxDQUU1NhEQaPRpV91i/X1mzU
         cWS/g/5MZd32f/GHd+zU1PlBITuXCNcqz7sx5541QeYT31gxizrDYG2YCmnNZvho9Jxc
         QLzg==
X-Gm-Message-State: ANoB5pl3//W4vZNYLRc0WLXoimF8p4t4xp9eHF0aUvkO/J60YOOHSdQL
        b64tPbZPGtY7CWD447bK6ZQKSy9SA/Fz9T1gzV4YWACrdMU=
X-Google-Smtp-Source: AA0mqf4dbOqzcNvxZ3l+Iva7I2HdtJ8EXgHZV3kSJutR6EeXUiHciDw/+mlXHVV2X5Bu9gnG7G1jPdLMhhr4lYRQKao=
X-Received: by 2002:a05:6402:142:b0:461:7fe6:9ea7 with SMTP id
 s2-20020a056402014200b004617fe69ea7mr31297027edu.94.1669322079857; Thu, 24
 Nov 2022 12:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20221124053201.2372298-1-yhs@fb.com> <20221124053217.2373910-1-yhs@fb.com>
In-Reply-To: <20221124053217.2373910-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 24 Nov 2022 12:34:28 -0800
Message-ID: <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 9:32 PM Yonghong Song <yhs@fb.com> wrote:
>
> @@ -16580,6 +16682,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>         env->bypass_spec_v1 = bpf_bypass_spec_v1();
>         env->bypass_spec_v4 = bpf_bypass_spec_v4();
>         env->bpf_capable = bpf_capable();
> +       env->rcu_tag_supported =
> +               btf_find_by_name_kind(btf_vmlinux, "rcu", BTF_KIND_TYPE_TAG) > 0;

It needs btf_vmlinux != NULL check as well,
since we error earlier only on IS_ERR(btf_vmlinux).
btf_vmlinux can be NULL at this point when CONFIG_DEBUG_INFO_BTF is not set.

In the previous discussion I thought we agreed to
fix convert_ctx_accesses() vs incorrect application of
BPF_PROBE_MEM for PTR_TRUSTED pointers.
But I didn't find it in this patch.
So I'm fixing both issues and planning to apply after testing.
