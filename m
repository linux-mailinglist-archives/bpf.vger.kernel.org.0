Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC187169A86
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2020 23:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWWop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Feb 2020 17:44:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33606 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWWop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Feb 2020 17:44:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so5472006lfl.0;
        Sun, 23 Feb 2020 14:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+ysc2B2E6ZUA9YFW/pXoZQG71MCNSdNR0YgJk6O1SM=;
        b=SGsWoRzlKz5TbHCwdxeRMuT/ZmzVjhVrwVYl5Ej+30lhB8VEBWsMAIqZ/2n7Wgbyze
         eFyaaZkursoA3NGOrm/2+FCBP+M4ThidcQbgKfrHcHTl+H2SYzY/yAOOQ3WzPZs4mEjc
         xEeqWrVLxjcZIQ6JoVdMxGjuwSLyp5RohslsFrQJbReRm/ALYvoAubNZ17lo/vI3YteI
         LEv8+f7i42zXbH6Z84a3AFXSgzSCrHIINk5L950Hwb5C574krJ+ffbwVeDyFv0zzdVSE
         iUIBfOVcgdWK52pVto5KRvc07Lg0talXcJOnqJ/NRf5s27G3lC2jNMfQrc3qvdhjcunq
         7HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+ysc2B2E6ZUA9YFW/pXoZQG71MCNSdNR0YgJk6O1SM=;
        b=O8mR9l89odHjGpCj0h79/wcr4wxgqq8gXzR5MBRuVH7XkcIdOOtucgN6XPitE26MbZ
         PfUq3L/ay+Ss7+5n6EXGeq2WVE3oXKkKijWbWDexy09zJbvngiEMQZAzbfxr0EFFPpGb
         wMOhrIa4+W3uhsQrQQJOiC9Vl2IHerqIJPY6WWGzjiLSjmEcqXyEzAEkvMP14vL0KgMz
         eAvC5/Y3t3dOTNUMSWFe/67JdvlmQvhNpCP/RnC+8s9i/l07uSUG4WYOpYh9Qx+8WhZ+
         6VUTt4E3+USuGbaUV75udmTYs4mmy7nJi49uCuAElh6SehkSwQJUNG42R7g43j19ramC
         1SSA==
X-Gm-Message-State: APjAAAUuMzlP+9ZgQ0R2IcQO8WYtkxaIw6X08OUjc/R09gzx+QSb3QYZ
        Pk9XDcBjl6z3ejU1B+rSDKIyGI0K+zhDFu4Zr0g=
X-Google-Smtp-Source: APXvYqwrQFQnSqr4ZzfVQy/WTfS4zQozgBwDIgCp+LwGCKZIBgjKogOZz8m3QK+TRv+xbUwl/wHutKmsMIdmiqIYI9Q=
X-Received: by 2002:a19:8585:: with SMTP id h127mr5024465lfd.196.1582497882620;
 Sun, 23 Feb 2020 14:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221165801.32687-1-steve@sk2.org>
In-Reply-To: <20200221165801.32687-1-steve@sk2.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 23 Feb 2020 14:44:31 -0800
Message-ID: <CAADnVQ+QNxFk97fnsY1NL1PQWykdok_ha_KajCc68bRT1BLp2A@mail.gmail.com>
Subject: Re: [PATCH] docs: sysctl/kernel: document BPF entries
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 21, 2020 at 10:18 AM Stephen Kitt <steve@sk2.org> wrote:
>
> Based on the implementation in kernel/bpf/syscall.c,
> kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> in bpftool-prog.rst.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1c48ab4bfe30..89c70ea7de7c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -102,6 +102,20 @@ See the ``type_of_loader`` and ``ext_loader_ver`` fields in
>  :doc:`/x86/boot` for additional information.
>
>
> +bpf_stats_enabled
> +=================
> +
> +Controls whether the kernel should collect statistics on BPF programs
> +(total time spent running, number of times run...). Enabling
> +statistics causes a slight reduction in performance on each program
> +run. The statistics can be seen using ``bpftool``.
> +
> += ===================================
> +0 Don't collect statistics (default).
> +1 Collect statistics.
> += ===================================
> +
> +
>  cap_last_cap
>  ============
>
> @@ -1152,6 +1166,16 @@ NMI switch that most IA32 servers have fires unknown NMI up, for
>  example.  If a system hangs up, try pressing the NMI switch.
>
>
> +unprivileged_bpf_disabled
> +=========================
> +
> +Writing 1 to this entry will disabled unprivileged calls to ``bpf()``;

'will disable' ?

It doesn't apply to bpf-next with:
error: sha1 information is lacking or useless
(Documentation/admin-guide/sysctl/kernel.rst).
error: could not build fake ancestor
Patch failed at 0001 docs: sysctl/kernel: Document BPF entries
