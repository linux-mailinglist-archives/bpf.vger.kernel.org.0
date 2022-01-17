Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93F4902D3
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 08:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiAQHPr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiAQHPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 02:15:45 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F919C061574
        for <bpf@vger.kernel.org>; Sun, 16 Jan 2022 23:15:45 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d11so5618218qkj.12
        for <bpf@vger.kernel.org>; Sun, 16 Jan 2022 23:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=QdiFuubSg0F153Y8Q2OtkdVQpcScGj+sKWBTnR2XAkY=;
        b=XPVYpychwEOy6s4QAxSNHQevz3GfbCRrmPRxGeiTxAkzQ0YCaacOJTMaOmt7E8GnFH
         WLWMEooebhPYsIGE4d9uo+4+Yh5wQW0qWHf1srcgiPdxfnPnifEPbvhNpiupbI7rWuzt
         wRe1IfOfABKAPd4SmscKtUoFlJM1hP0iih44pD+FfG6O1KN2GwpMLdUMeJJwJeo6gzff
         GfL4V4LmsIHmUW5RbZryxjuE8AxJmRPzYfNhMM/VSS3uysKOp12eGLaXrM3576ih0lXQ
         5WcPZMsPiNd1TWZbsFhMXrFvO8xtVUmhpa2+jryf2zFw5Ix05gC7dLrd5xp8ABeAsbKk
         sasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QdiFuubSg0F153Y8Q2OtkdVQpcScGj+sKWBTnR2XAkY=;
        b=04nxe8+9uQsZ7+wLNyJgjZQT+QJ/cvihuaqZLwBP56X1A4txqlSUrrqqSjO1RlUNCC
         bdM/ki9HS7XCiC4SoIWGYAUxrT26NwgwvTKNVaOWXXCxU2HrYpVnJdPVF2etg8N/YZoB
         Uu1lr4+uRwNvKVH6kHMKOXx4EzH1PB+W1q+ZLvsPs624OS/o+Nc2QD0fOx8WIRpZOvjm
         xJP8cyj4ijTKGuTV/RUFHkZKGc1BpKmQzHu02NU0aDyBIH6rweDu4VT/9zg8VglKaMi0
         ZWDiamdet0ZsjvoTAvNdVs9YW3a1Xsqo9wKI13UafLOiKyvXwn+zzDrLaZ8nhNDfEZ2C
         saNQ==
X-Gm-Message-State: AOAM530ujl9JMJl+ocNQl9VjPIM9gU+IzeOUECGpxndAuIi2HbuqJXyf
        AWk28I/lo91CGKI+0WkO/AQocLOAVNG7bMNbVIRr43w0Ahw=
X-Google-Smtp-Source: ABdhPJx1mnYsuj05segXAVRx9vOu0+xtLnrQoWoRozxjLbYLzbFVYSzMibLKyrW8MFjOXT8AX4ckDDYy3zeCWf1cjnU=
X-Received: by 2002:a37:b104:: with SMTP id a4mr9112582qkf.778.1642403743654;
 Sun, 16 Jan 2022 23:15:43 -0800 (PST)
MIME-Version: 1.0
From:   Pony Sew <poony20115@gmail.com>
Date:   Mon, 17 Jan 2022 15:15:32 +0800
Message-ID: <CAK-59YH9+w4VMuHC2ECUsChZ=0nJRmQeKkcAwXFt2ugfmWHZWA@mail.gmail.com>
Subject: How do I implement bpf_prog_test_run with BPF CO-RE?
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello.
It seems like before bpf_prog_test_run is called, you need to call
bpf_prog_load. But in BPF CO-RE program, we already have
<program>_bpf__open and <program>_bpf__load which basically does the
same thing. My code look approximately like this:

-----test1_load.c---------------
#include <cgreen/cgreen.h>

Ensure(Load, load_test){
    /* should I call bpf_prog_load here? */
    bpf_prog_test_run(/* parameters */);
    /* what about bpf_object__close? */
}

TestSuite *load_tests() {
    TestSuite *suite = create_test_suite();
    return suite;
}

-----bpf_firewall.bpf.c---------
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>

SEC("xdp_prog")
int xdp_prog_main(struct xdp_md *ctx){
    /* main program */
}

 char LICENSE[] SEC("license") = "GPL";

------bpf_firewall.c---------------
#include <cgreen/cgreen.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include "bpf_firewall.skel.h"

TestSuite *load_tests();

int main(int argc, char **argv) {
    struct bpf_firewall_bpf *obj;
    int err = 0;

    obj = bpf_firewall_bpf__open();

    err = bpf_firewall_bpf__load(obj);

    err = bpf_firewall_bpf__attach(obj);

    TestSuite *suite = create_test_suite();
    add_suite(suite, load_tests());
    run_test_suite(suite, create_text_reporter());

    bpf_firewall_bpf__destroy(obj);
    return 0;
}

How do I implement bpf_prog_test_run with BPF CO-RE?

Best regards,
Poony.
