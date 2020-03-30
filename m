Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8592C198051
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgC3P7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 11:59:38 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33287 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3P7h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 11:59:37 -0400
Received: by mail-lj1-f176.google.com with SMTP id f20so18695919ljm.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuRQyN7bkkSmBmFvAy2z0wm04WnOnH5g3Y1VtvXKj34=;
        b=HzK2lWWdP4vOW+qIWpbtImtmVgtaVNGYb42cvwDT7UPKE7UchqODMo4mB7tCUWN8Rf
         kLfj4vRbwxPMcnGOraeq99twiX+S5GRQSZipBxbtTxcAy6EBgaY65dNuSd83TQGgDcUM
         0UNRQedln0j/4mEhT8r12/PVE6Je4HnB9nWTiyIX+tlqkgQVIUJxvU7qVGn1oGhyILlK
         sQWfdySX2Vqi265aVRF1hUiG95s0awJyFYTluFybNvyD1PyLpNuIoXn+0NDa3dJNghER
         b63977W1MW7gFcwUn9RT5BYw/tkQD6EiQbMOzJCxcPe2oReur7MQEhGhwbS6tkM7S3Rq
         9nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuRQyN7bkkSmBmFvAy2z0wm04WnOnH5g3Y1VtvXKj34=;
        b=hIG6cDSMW/i2GMuPNC8Y7KmBjz8EO7CxzJky7Q0VN1Jobzeex8XTRKxfqVc4PXaEVK
         7aK2sYtLGmtK7PzWQZuo22teEYPLLD3Mvhd9b5531f/awgntoBhZmk5haWCmupp+SGsa
         dHq4wlsWBo9m86kTFTamt2b2cPZhZilDbvk2SWHc0RKPsI9vTGAItQGvhBg6yT2YDCxb
         WtmQoswf6eaiOSxLGDyDPDY4eBEzNGRyeFT6gYioE2uIAZ8tguFjK64ce3OZOX0nTnOY
         LXdp8zek9Tc1erUwG8KIjyRD6ofLoghQ8OgBu9H+GaaWhMGsO+W8f0tEPa1GofuSvGCn
         tGlQ==
X-Gm-Message-State: AGi0PuZ/fD/abfKrLN5Lv/G/DZ7ex9AwN0fa/++hVgxVd2MixLTePhiw
        u7Q1cgDmbLYJllpby4MatRZnWLEl20+SjKa+IK8=
X-Google-Smtp-Source: APiQypI48b9gxH6USfZ1wCD0YTX6TAVIFPaOX5QPlhyv7Iy6s4hZaocuj1rQc24NI1rYnXKNmERI+Ey73cydO1Zhsgk=
X-Received: by 2002:a2e:7805:: with SMTP id t5mr7826197ljc.144.1585583974562;
 Mon, 30 Mar 2020 08:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
In-Reply-To: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Mar 2020 08:59:23 -0700
Message-ID: <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     Jann Horn <jannh@google.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
>
> I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> of CONFIG_GCC_PLUGIN_RANDSTRUCT.

Is it a theoretical stmt or you have data?
I think it's the other way around.
gcc-plugin breaks dwarf and breaks btf.
But I only looked at gcc patches without applying them.
