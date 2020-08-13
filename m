Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B82431F6
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 03:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMBNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 21:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHMBNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 21:13:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DEC061383
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 18:13:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so2156654lfi.5
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWYdny5TPME+M+iQKECCVkJDywZUM3Lv5lxW+w10+Uo=;
        b=tgrJztZc+kUX3wLGWX1x2qIYi/P1Y0w57Fwtn+KBTKggXs4/8s3H9rKNGzaC7ABWsB
         QdJSD6/+ASdmBJDkH/ys4D/2RkyDDC6/3OgQ1gv3pICb1ESOamFdSxlFi81V+/YNrUyR
         VQybOqToBzJHElgO2I+L0SGSO9xxso5asFbC2JFMm4uKro2eMWZFx8W4Wrlcw7LvF8Mu
         er2wE3jvGoaSy6yvnwOxXi0ETmaOCnn5GphRPew6zTiLgcLFzTum/z9RoQBsy3aAEcx0
         vuRBT1r8iKMJ7CN4jHUbLDLn7izw002QJ7rNfyarw1Ul4G0XTiXgwRt8TPGENbsOum3G
         htIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWYdny5TPME+M+iQKECCVkJDywZUM3Lv5lxW+w10+Uo=;
        b=qI1TdQghvaOtWEQfYAiXHNYnryxdcfkRIhz9YMJHPkfcC1sWaNHZRrSJxhpKOkx2HI
         VN7cVJcj1znelMcrHVK/7aBmm74oUd18HR2gnUDylvFSn8k6BThNBVyGsLqPL1Jp7q6J
         Endos4OcSlLDtdX/k+foFhliTIxIxjJ4gLgTN/OM3trIom+QDodJn/rWr+4bjko3DsQe
         Hc6y1uBSdDrz1DYvLwJertMn/0xakxW5OhqdSIArv9k1TccEPh63ZhIRPyVVvnCJPi7B
         av/qbG1RxTwSXQVagrqQaFSNvgFqYlddWeeazO2/GonBY8f/Vi9clbOd161g7dC54JAp
         kMDg==
X-Gm-Message-State: AOAM533qFfVu6oYDu7CcXh/2Wqhy0a8SRbXypKSszKUAkBg9xIyEKu+S
        sM5kuAN5XYTynPdJ9+pWsGBAq+zPdeasHa/7FRE=
X-Google-Smtp-Source: ABdhPJzdYBv0N2cXnI9DnW86eF2VmzQK/xE/4X/QtgWDJ51uHEFGh2BFKbGgJOMC3H0deK7TJLYrp2lUSQxzHEdVuoc=
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr931035lfs.119.1597281188620;
 Wed, 12 Aug 2020 18:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200812143909.3293280-1-jean-philippe@linaro.org> <CAEf4BzZKEfgHSeZMMHfGt=WvcChuDh+a_0pyBbwU3riKSt2z5w@mail.gmail.com>
In-Reply-To: <CAEf4BzZKEfgHSeZMMHfGt=WvcChuDh+a_0pyBbwU3riKSt2z5w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 12 Aug 2020 18:12:57 -0700
Message-ID: <CAADnVQ+sw4p0O5E8UiU=wh-yN69pW6z1jeWUEU5ig1xRbk0fxQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Handle GCC built-in types for Arm NEON
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 10:35 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 12, 2020 at 7:42 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > When building Arm NEON (SIMD) code from lib/raid6/neon.uc, GCC emits
> > DWARF information using a base type "__Poly8_t", which is internal to
> > GCC and not recognized by Clang. This causes build failures when
> > building with Clang a vmlinux.h generated from an arm64 kernel that was
> > built with GCC.
> >
> >         vmlinux.h:47284:9: error: unknown type name '__Poly8_t'
> >         typedef __Poly8_t poly8x16_t[16];
> >                 ^~~~~~~~~
> >
> > The polyX_t types are defined as unsigned integers in the "Arm C
> > Language Extension" document (101028_Q220_00_en). Emit typedefs based on
> > standard integer types for the GCC internal types, similar to those
> > emitted by Clang.
> >
> > Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
> > max(), causing a build bug due to different types, hence the seemingly
> > unrelated change.
> >
> > Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
