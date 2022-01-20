Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C449562F
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 22:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiATV56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 16:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347730AbiATV56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 16:57:58 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080AEC061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 13:57:58 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y22so8662745iof.7
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 13:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVf9uXVhqjWpPlNQlEjiTsy1ZZ+052D3WIXIqp1U9FU=;
        b=CxXwqrIxUZ6Flb7C7oxmvdh9n/fiYRhHidsnN7VpZAk9X1BjnfpOFy9Mrny5l0Wr8k
         Y4Ul64OgYd00HNCrtFYRlfysHbIHi3SnT5AE9oO3noHK2cjvhaGmY9byssHMybMkr36f
         JbIoFaC/hYwthHOHtQLgJKaRZTQDe+tBYaFEZEthL1q0avluoZu1uH59nWUWQ8jmpsPo
         UQkWnFIqIvbo8a+5bKIVtZs/NGgXWxYln9fvAasr/aufZh+fxRwKJWHRRwvVO0uKCxXZ
         Troek5HHGB1+Q5PuxavTwn0oGS0DJTksynFUABh/275+PIGSJe5XtLciMQi/D2STx1DU
         pX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVf9uXVhqjWpPlNQlEjiTsy1ZZ+052D3WIXIqp1U9FU=;
        b=ZYtrNFIfNpLBsr0JIWb2Om3ijB+8YbF+WtsRFTdek2Bsr5jymuMe+LmfCLNwfzowH1
         2SRr5CB8P0OnFEbrhG4GEk5FUm4P4FDZ+dDBKSqOiAXp7JQhJm7noVDiFmKjXRyH95k9
         yHrdRFnIMdYGUaHYyRwFb8DvHHf9SFAZyvBEEAXj5uCFSkL2ZaTbipDQ6A+zZwvCuIXi
         Qa8YDtw3FBL7KlOJKUFfhTWGdFvpQsVi5iNyavjlsXGwRnwdCIffYjOZtL/MVc1gXlq4
         Kj5578bSKgT+1erl1ZEnKdjvZHmIXVaPv+/R6x+Szi9nzJEWCszSO3xFKeNVzr41NKde
         EIzg==
X-Gm-Message-State: AOAM533k0kzeEeUW8SI+526AwS/nnGJlrdjb/84OwJ45Tl2sy4ZAUahk
        2SdXkUFaYvaHACfYMQf6ck/SahhBuwBnW4pLcMbh6MBc
X-Google-Smtp-Source: ABdhPJwVHYzSe8/BIuEIRhsep3/PDU/k+Nzr60qBYzVyZH4HnVWphP1Y6KmTMqiyNzoOPYk6ufZzlr96pzIOVge5Zo4=
X-Received: by 2002:a02:bb8d:: with SMTP id g13mr371964jan.103.1642715877358;
 Thu, 20 Jan 2022 13:57:57 -0800 (PST)
MIME-Version: 1.0
References: <CAK-59YH9+w4VMuHC2ECUsChZ=0nJRmQeKkcAwXFt2ugfmWHZWA@mail.gmail.com>
In-Reply-To: <CAK-59YH9+w4VMuHC2ECUsChZ=0nJRmQeKkcAwXFt2ugfmWHZWA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 13:57:46 -0800
Message-ID: <CAEf4Bzb2_bg7ugTUhYrA=0rdeyEg5NStLivpNTW_XOeN5rtz9w@mail.gmail.com>
Subject: Re: How do I implement bpf_prog_test_run with BPF CO-RE?
To:     Pony Sew <poony20115@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 17, 2022 at 7:57 AM Pony Sew <poony20115@gmail.com> wrote:
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

It has nothing to do with BPF CO-RE. It's a BPF skeleton question.

But regardless, bpf_prog_test_run() expects BPF program FD, which you
can get with bpf_program__fd(skel->progs.xdp_prog_main) and pass the
result to bpf_prog_test_run() call.

>
> Best regards,
> Poony.
