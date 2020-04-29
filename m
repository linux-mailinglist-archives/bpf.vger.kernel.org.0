Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386771BE393
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2QRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2QRw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 12:17:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80854C03C1AE
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 09:17:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so2669057wmh.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hC339AlYWIKjaIvmnsbzPnIvgC6f8npdAivdjP/WncE=;
        b=duJ1CAR3oC0XJTSkov4YIS7U0gdKnijRTK0zU7OF120jvwnIAqXrOiZukp76t7gqEg
         +sws3pAd0Fp715kcqIQUZ6ILybSDYsmpYBhd+d742FyzXAnETdeW6IOhAPErL4HwCrgM
         462kB+7nxNLniPCRDs6WRnbW6aa9rbAFfqsEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hC339AlYWIKjaIvmnsbzPnIvgC6f8npdAivdjP/WncE=;
        b=YIhl6RdXV875ic1l0gWrkzZMWlMR0h9z5dAYorl924br/GH6zEwF/V91X2NG7qazzW
         KEqxv3mmE95PHkoas7k91MhdjX6sQW1CvZDBrPmGN1YaZDsYItbFpcFJDdH+i2GGT+Vx
         MELBpAITlxYOXnkVlrBfCmYxtOUZ4nqpO1Tz4jPAMd2Je7QmX1DNKVThl/MmqYiHgRMP
         omjst0kCztcbdgmrWf7oCRWYKQVQuDNIwEj+eZFwMFjC/IWUqnpNJIpR1KNYdQxmQwzs
         qqxE4JFRiXB0xuZr1hQ70MRUiYQK1LO1Ks1aq15CiT/oGTU7cov8CF11tK6O967RGYvQ
         m54w==
X-Gm-Message-State: AGi0PuYoUh55bDd/uUfGnwS0rCVSosdXClrFqlwpkjAam/MN/hz2AXRv
        DFnNOeLG01IcRkHCorNIFMBlnQ==
X-Google-Smtp-Source: APiQypKqSi/3QCJ/S4sT8BuxhRSzNwixocTEGZPtC0ytAcL+7Al93xW6am13M7Ws4l0ZyznfHMvcCQ==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr4139049wma.138.1588177071094;
        Wed, 29 Apr 2020 09:17:51 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d143sm8275651wmd.16.2020.04.29.09.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:17:50 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 29 Apr 2020 18:17:47 +0200
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200429161747.GA113900@google.com>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
 <CACYkzJ6XyHqr1W=LWV-5Z0txFBtvPCwRY-kczphy+pS7PEitqQ@mail.gmail.com>
 <b5652508-f727-b936-79b5-f8da658395f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5652508-f727-b936-79b5-f8da658395f5@linux.intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

So I was able to reproduce the issue and also fix it (will separately
send a patch).

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..1bdd027766d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,7 +55,7 @@ LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
         struct fs_context *src_sc)
-LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
         struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)

So what was happening was that:

bpf_lsm hook for fs_context_parse_param was returning 0 which led this
bit of logic to believe the parameter was parsed by the LSM.

int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter
*param)
{

[...]
        ret = security_fs_context_parse_param(fc, param);
        if (ret != -ENOPARAM)
                /* Param belongs to the LSM or is disallowed by the
                 * LSM; so
                 * don't pass to the FS.
                 */
                return ret;

        if (fc->ops->parse_param) {
                ret = fc->ops->parse_param(fc, param);
                if (ret != -ENOPARAM)
                        return ret;
        }
[...]

This resulted in the fs_context->dev_name being NULL and the following
chain to throw an -EINVAL resulting in unsuccessful mount of the root
file-system:

- do_mount_root -> do_mount -> do_new_mount -> vfs_get_tree ->
-> fc->ops->get_tree -> legacy->get_tree -> fc->fs_type->mount ->
ext4_mount -> mount_bdev -> blkdev_get_by_path -> lookup_bdev

- KP


On 29-Apr 15:45, Mikko Ylinen wrote:
> 
> 
> On 29/04/2020 15:34, KP Singh wrote:
> > Thanks for reporting this! Can you share your Kconfig please?
> 
> This is what I originally started with
> https://raw.githubusercontent.com/clearlinux-pkgs/linux-mainline/master/config
> 
> but I also tried your _LSM_ settings found in this
> https://lore.kernel.org/bpf/20200402040357.GA217889@google.com/
> 
> -- Regards, Mikko
