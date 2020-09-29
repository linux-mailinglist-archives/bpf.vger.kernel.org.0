Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C288027BF49
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 10:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI2IZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgI2IZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 04:25:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB2C061755
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 01:25:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p9so13761084ejf.6
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DOX5x6lo0pXpeFKxSyetZLoch90Egpp2kk5wJH83gvU=;
        b=HcUHxPDUxH/9Fek2axkaiSKqCV+EZ12vFvEW9/eww1VL3KIr7nJBc9hUPP4kfHGQE6
         Oi6DNbi95bH8aPzbHeftrIJ6i+5ZFQJi1yPji09Wvi/KmynRYPsVDFg+x38/mNkMRBZD
         hYvbfhjR7ukIbpmcJJaevk75OaPWvs48QQtmH2hm0tny7CTg1OU28wPN2Xl5Yx9kesvx
         LAeaGuM7JGQoHy3t1f4NU/fBLfuUccKtdgMk95mMjLRN4AJMOO8sufYTqVY/V1nGJ6a+
         aWrSbjXlC54imu7oezBoFIWwtQL+XV2d40U5Tiejy7ZRuo15Ej7L5L4NQS8Sst318VBu
         WHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DOX5x6lo0pXpeFKxSyetZLoch90Egpp2kk5wJH83gvU=;
        b=rrJmXwTB1nRNGEiilFXqwmdZ/InQBuHXFc5Ta6L+Mhe3+0YJB8IlTJUS71sj6JbEOO
         DgFu7cfH0X+GkpIbJCqoWZXASODms7FlrpUPjNtu5uL3yfhl5STfkgZOJmok2ncPNwmw
         YmOnbns/7w//AIvCKJcmoWZ13N7ub4DE2ziCCBTOC9IY5RRn7JWus/ge9W/FOEtHYAYj
         GTnqLC9nGtoQIhe9myPxR6IfGKXO0dZv/szF1bTwEaNWyXavxMvbRwj8I30YKZ498xr8
         JOnQTH/qBZNtH+dmDuO2nd+b6ZUVix9ecdPw6V9zVrRsz/8sGSsmmbwlKbe+NykE8ReL
         93lQ==
X-Gm-Message-State: AOAM533tL3TOElBhOdmNq65dW5JOC5Lx8SmcboPUpsodL5YxI5JR6+k9
        ps2BBwW0Q2Fh/Ep4pGlF0NM+Vl51CEt+zwyMd8Y=
X-Google-Smtp-Source: ABdhPJwtBr+lIXY66krf2HhraSg+7tymbwa+ZRmgHAsBX7DIq2zBOtJmxD+S/NGWwxN2ZymByHCQL/4IqM61oaJzvCw=
X-Received: by 2002:a17:906:aec1:: with SMTP id me1mr2765456ejb.225.1601367923927;
 Tue, 29 Sep 2020 01:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com> <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 29 Sep 2020 11:25:12 +0300
Message-ID: <CAMy7=ZXdR5MgHLiqvgVyavVCLX3Erm=DURdEWZTYPMyJGC9Frw@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 29 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2020 =D7=91-4:29 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Sep 28, 2020 at 5:01 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > Hi Andrii,
> >
> > I used BPF skeleton as you suggested, which did work with kernel 4.19
> > but not with 4.14.
> > I used the exact same program,  same environment, only changed the
> > kernel version.
> > The error message I get on 4.14:
> >
> > libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> > libbpf: failed to determine kprobe perf type: No such file or directory
>
> This means that your kernel doesn't support attaching to
> kprobe/tracepoint through perf_event subsystem. That's currently the
> only way that libbpf supports for kprobe/tracapoint programs. It was
> added in 4.17 kernel, which explains what is happening in your case.
> It is still possible to attach to kprobe using legacy ways, but libbpf
> doesn't provide that out of the box. We had a discussion a while ago
> (about 1 year ago) about adding that to libbpf, but at that time we
> didn't have a good testing infrastructure to validate such legacy
> interfaces, plus it's a bit on the unsafe side as far as APIs go
> (there is no auto-detachment and cleanup with how old kernels allow to
> do kprobe/tracepoint). But we might reconsider, given it's not a first
> time I see people get confused and blocked by this.
>
> Anyways, here's how you can do it without waiting for libbpf to do
> this out of the box:
>
>
> int poke_kprobe_events(bool add, const char* name, bool ret) {
>   char buf[256];
>   int fd, err;
>
>   fd =3D open("/sys/kernel/debug/tracing/kprobe_events", O_WRONLY | O_APP=
END, 0);
>   if (fd < 0) {
>     err =3D -errno;
>     fprintf(stderr, "failed to open kprobe_events file: %d\n", err);
>     return err;
>   }
>
>   if (add)
>     snprintf(buf, sizeof(buf), "%c:kprobes/%s %s", ret ? 'r' : 'p', name,=
 name);
>   else
>     snprintf(buf, sizeof(buf), "-:kprobes/%s", name);
>
>   err =3D write(fd, buf, strlen(buf));
>   if (err < 0) {
>     err =3D -errno;
>     fprintf(
>         stderr,
>         "failed to %s kprobe '%s': %d\n",
>         add ? "add" : "remove",
>         buf,
>         err);
>   }
>   close(fd);
>   return err >=3D 0 ? 0 : err;
> }
>
> int add_kprobe_event(const char* func_name, bool is_kretprobe) {
>   return poke_kprobe_events(true /*add*/, func_name, is_kretprobe);
> }
>
> int remove_kprobe_event(const char* func_name, bool is_kretprobe) {
>   return poke_kprobe_events(false /*remove*/, func_name, is_kretprobe);
> }
>
> struct bpf_link* attach_kprobe_legacy(
>     struct bpf_program* prog,
>     const char* func_name,
>     bool is_kretprobe) {
>   char fname[256], buf[256];
>   struct perf_event_attr attr;
>   struct bpf_link* link;
>   int fd =3D -1, err, id;
>   FILE* f =3D NULL;
>
>   err =3D add_kprobe_event(func_name, is_kretprobe);
>   if (err) {
>     fprintf(stderr, "failed to create kprobe event: %d\n", err);
>     return NULL;
>   }
>
>   snprintf(
>       fname,
>       sizeof(fname),
>       "/sys/kernel/debug/tracing/events/kprobes/%s/id",
>       func_name);
>   f =3D fopen(fname, "r");
>   if (!f) {
>     fprintf(stderr, "failed to open kprobe id file '%s': %d\n", fname, -e=
rrno);
>     goto err_out;
>   }
>
>   if (fscanf(f, "%d\n", &id) !=3D 1) {
>     fprintf(stderr, "failed to read kprobe id from '%s': %d\n", fname, -e=
rrno);
>     goto err_out;
>   }
>
>   fclose(f);
>   f =3D NULL;
>
>   memset(&attr, 0, sizeof(attr));
>   attr.size =3D sizeof(attr);
>   attr.config =3D id;
>   attr.type =3D PERF_TYPE_TRACEPOINT;
>   attr.sample_period =3D 1;
>   attr.wakeup_events =3D 1;
>
>   fd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLO=
EXEC);
>   if (fd < 0) {
>     fprintf(
>         stderr,
>         "failed to create perf event for kprobe ID %d: %d\n",
>         id,
>         -errno);
>     goto err_out;
>   }
>
>   link =3D bpf_program__attach_perf_event(prog, fd);
>   err =3D libbpf_get_error(link);
>   if (err) {
>     fprintf(stderr, "failed to attach to perf event FD %d: %d\n", fd, err=
);
>     goto err_out;
>   }
>
>   return link;
>
> err_out:
>   if (f)
>     fclose(f);
>   if (fd >=3D 0)
>     close(fd);
>   remove_kprobe_event(func_name, is_kretprobe);
>   return NULL;
> }
>
>
> Then you'd use it in your application as:
>
> ...
>
>   skel->links.handler =3D attach_kprobe_legacy(
>       skel->progs.handler, "do_sys_open", false /* is_kretprobe */);
>   if (!skel->links.handler) {
>     fprintf(stderr, "Failed to attach kprobe using legacy debugfs API!\n"=
);
>     err =3D 1;
>     goto out;
>   }
>
>   ... kprobe is attached here ...
>
> out:
>   /* first clean up step */
>   bpf_link__destroy(skel->links.handler);
>   /* this is second necessary clean up step */
>   remove_kprobe_event("do_sys_open", false /* is_kretprobe */);
>
>
> Let me know if that worked.
>

Thanks Andrii,

I made a small change for the code to compile:
skel->links.handler to skel->links.kprobe__do_sys_open and same for skel->p=
rogs

After compiling the code, I'm now getting the following error:
failed to create perf event for kprobe ID 1930: -2
Failed to attach kprobe using legacy debugfs API!
failed to remove kprobe '-:kprobes/do_sys_open': -2

As our application is written in go,
I hoped libbpf would support kernel 3.14 out of the box, so we can
just call libbpf functions using cgo wrappers.
I can do further checks if you'd like, but I think we will also
consider updating the minimal kernel version requirement to 4.18

> > libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> > 'do_sys_open' perf event: No such file or directory
> > libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> > failed to attach BPF programs: No such file or directory
> >
>
> [...]
