Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13433493A1D
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiASMMx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 07:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiASMMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 07:12:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83ECC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 04:12:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bu18so8552904lfb.5
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 04:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMAX++J32gttDcd4ezfSvaj25iJYc5sobnRtT5oJ+bg=;
        b=bfzQzaJw/g3/z+p530phx478SwFjNOaZOlccMuynN/b8UOigOIgJJhN5DtDFw+xcLZ
         ivfjvQFcxwOEklg2lhj9p+6PckW8NuVuCK2ZEales3zbOID55OIPTC/jm4iwmYl0OU8G
         HTmEuEeYdU1v6nN7fWTXbIebwMtKLQSTGynac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMAX++J32gttDcd4ezfSvaj25iJYc5sobnRtT5oJ+bg=;
        b=xjfo7ZEy1vffdPn2AM3Goo6wgxnlmA040mMBy50MiNadyxyUwVpy0Pby0++N85HfXi
         JEwQIA6jTM3cYWUgIskwAvQst+XiGEDtFtFiFI/CEAJQQLvvBXVPnORjrR8RJgNUNYgF
         YrAu8VbwnU9HgxStck97GJZJJKF6bkjW8RAfocUofdGY3Nkgt4dXT06H/mmxEVasq+H5
         ufCXTCqxEtdScTRLOfT30ZV+89kUScIF/tvq7x9wwnjoY+xu77emSWqoFrU8wCCUpvge
         wJj5RIAqi4/npqJzKdvXrCKYPXzdXujT/D7DyfTlaYyzTo3oimz+4uTwSvpjeY2flo3t
         yU+w==
X-Gm-Message-State: AOAM531LUFa1Jc/LfoEPfFiSmSAG5ZX2qgHzaFEuXp13vZqmrfWFr1+I
        yOnYDf8TUDxw3zDWNI61bAhWVuUte3TGa86HkOi5VEOaB42z6A==
X-Google-Smtp-Source: ABdhPJwPT9VPUXoTET6Q00SwEc4q3qLROUclrQiLabWAlDwaJpp5rBgzB1JvjG1tfMSnzWij0eWgWJCjau5mqtuwMWE=
X-Received: by 2002:a2e:9f41:: with SMTP id v1mr21837857ljk.274.1642594371071;
 Wed, 19 Jan 2022 04:12:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK-59YH9+w4VMuHC2ECUsChZ=0nJRmQeKkcAwXFt2ugfmWHZWA@mail.gmail.com>
In-Reply-To: <CAK-59YH9+w4VMuHC2ECUsChZ=0nJRmQeKkcAwXFt2ugfmWHZWA@mail.gmail.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Wed, 19 Jan 2022 07:12:40 -0500
Message-ID: <CAHap4zuEEq841zejx24mtQGx66BmOOBjXu12om4g8PjN=Sx8ig@mail.gmail.com>
Subject: Re: How do I implement bpf_prog_test_run with BPF CO-RE?
To:     Pony Sew <poony20115@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 17, 2022 at 2:16 AM Pony Sew <poony20115@gmail.com> wrote:
>
> Hello.
> It seems like before bpf_prog_test_run is called, you need to call
> bpf_prog_load. But in BPF CO-RE program, we already have
> <program>_bpf__open and <program>_bpf__load which basically does the
> same thing. My code look approximately like this:
>
> -----test1_load.c---------------
> #include <cgreen/cgreen.h>
>
> Ensure(Load, load_test){
>     /* should I call bpf_prog_load here? */

bpf_prog_test_run() needs prog_fd. You're already calling
bpf_firewall_bpf__load() in bpf_firewall.c, you can get the program fd
by using
prog_fd = obj->progs.<program>.prog_fd;

>     bpf_prog_test_run(/* parameters */);
>     /* what about bpf_object__close? */
> }
>
> TestSuite *load_tests() {
>     TestSuite *suite = create_test_suite();
>     return suite;
> }
>
> -----bpf_firewall.bpf.c---------
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>
> SEC("xdp_prog")
> int xdp_prog_main(struct xdp_md *ctx){
>     /* main program */
> }
>
>  char LICENSE[] SEC("license") = "GPL";
>
> ------bpf_firewall.c---------------
> #include <cgreen/cgreen.h>
> #include <bpf/libbpf.h>
> #include <bpf/bpf.h>
> #include "bpf_firewall.skel.h"
>
> TestSuite *load_tests();
>
> int main(int argc, char **argv) {
>     struct bpf_firewall_bpf *obj;
>     int err = 0;
>
>     obj = bpf_firewall_bpf__open();
>
>     err = bpf_firewall_bpf__load(obj);
>
>     err = bpf_firewall_bpf__attach(obj);

I don't think you need to call __attach() if you only want to perform
some tests with bpf_prog_test_run.

>
>     TestSuite *suite = create_test_suite();
>     add_suite(suite, load_tests());
>     run_test_suite(suite, create_text_reporter());
>
>     bpf_firewall_bpf__destroy(obj);
>     return 0;
> }
>
> How do I implement bpf_prog_test_run with BPF CO-RE?

You don't need to worry about it. You're using the skeleton and hence
libbpf underneath, it'll take care of performing all CO-RE relocations
when loading the program.

This approach is used many times in tools/testing/selftests/bpf, for
instance tools/testing/selftests/bpf/prog_tests/map_ptr.c does exactly
what you're looking for.

>
> Best regards,
> Poony.
