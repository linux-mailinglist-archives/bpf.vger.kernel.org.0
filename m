Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A2133300D
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 21:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCIUij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhCIUiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Mar 2021 15:38:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF2C06174A
        for <bpf@vger.kernel.org>; Tue,  9 Mar 2021 12:38:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x4so22819121lfu.7
        for <bpf@vger.kernel.org>; Tue, 09 Mar 2021 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyP6j+ZtJdltq5she/GEKEy2lAs3MPhk+nX+6aH6wBc=;
        b=HUEzteRdiEU+qtvHPBHmVFa5eLJ1zcmRYPOdmH/putIRMnd3sQIzQtMRdF3alViL58
         eq79AuZNsRPh3A/ICriQXLXHPbbWCliY0qc7TIKjft43llwZ3pMpIp4syWpKTCTQKcXQ
         4A4RoO50OWofVxD7OXlAK+Lw6JN3rovza5J4xVpCPtOx3lKtCCy2pfeGlpAm8OQBrUTz
         kMhZX9VNKNLELlDCh4A7nIZ/0yS9IBifjRvWYaOCzvSx++QKpBTvGEG9n0nCh3n0n3a4
         VdS8ANG7CDVPliGX6ZNS/x+yZA1y/+BoTYgwgoscutPWsvZWucfjihvcca5PmdmVupKB
         KaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyP6j+ZtJdltq5she/GEKEy2lAs3MPhk+nX+6aH6wBc=;
        b=EGrozf0i8stUPLkJ5NVx5LhWcd7yl5ARnm2Km2aO9lAjfd83KKjiUC2OPjlemthkV3
         o5X6b402cN6bLY4H9c40gKSGMMXCnqMlVN9ol1DRmsienjdvqdnv+C64HF7EMgLrfGle
         kACH5/tfV5ljPJiDF+3QPjvxRxDtvvwygzAf22dxz4V63QQiHu4v6h0EZ0dZEG5Ld2/Z
         k5PEtTkloM92THWi3AAm2zYJByGAC+SFrHqAOnfooplyiRP6bXqh4mjg2l6MYH0EDVaQ
         8R4Ikjqn14TozKrVF9YfaRbz+zpLB4Pxhnv7ucKcbmf0CVbuIsM363vGcBF4FXmC0zZw
         hz3Q==
X-Gm-Message-State: AOAM532hago1yjPF+4C7mFnNtUZ2WhjgHFvuwSqkKgPpAZfiyb3E5p0Q
        KccFIVwenkZNTJ4E8PwCAAblRPkSf0P2O4n5xPc=
X-Google-Smtp-Source: ABdhPJyya3mPL8NBQCN8AxnnuRIUj9HjN5nc7nL12e/YS9yjjqQDE05/uiqCvUtZWkHPdZBt2A47D6yv4pih9NYiDEM=
X-Received: by 2002:ac2:5ec2:: with SMTP id d2mr19424098lfq.214.1615322299803;
 Tue, 09 Mar 2021 12:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20210309185028.3763817-1-yhs@fb.com>
In-Reply-To: <20210309185028.3763817-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Mar 2021 12:38:08 -0800
Message-ID: <CAADnVQLqMGHC8OUmQb4EizjQQKmKBikQj9VxHKX1tvp4_7XybQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: don't do bpf_cgroup_storage_set() for
 kuprobe/tp programs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 9, 2021 at 10:50 AM Yonghong Song <yhs@fb.com> wrote:
>                 while ((_prog = READ_ONCE(_item->prog))) {              \
> -                       bpf_cgroup_storage_set(_item->cgroup_storage);  \
> +                       if (set_cg_storage) {           \
> +                               bpf_cgroup_storage_set(_item->cgroup_storage);  \
> +                       }                               \

Extra {} are unnecessary. I removed them while applying.
Thanks!
