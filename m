Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278716A16F2
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 08:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBXHKI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 02:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 02:10:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0D1421C
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 23:10:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso1832696pjb.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 23:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3/Q3YSYugVmUu8idVs4rogRGpXXSgChV16OURtTKMZM=;
        b=NxAVO+jgU7enfC4THnPnmuAyUOFR8DHSCFoF70omutRqRn/nJjPmOzabFH3b8S0Q0f
         Mq3MAIHi7KjxXYdVxi/m7SdhJBnw4uZ17MvGa/RIqKfnvyg4UajnL3IQqyJQ/e149iSS
         lIc1Su2uX+zgUZcHrfhwLBVyIJ2Pthn7geSTPbpWSKo8C8FqmUFeUVL7NTnNgkYiFaI1
         zNe9hjh275dGgUoSY9rAPLzHtRmGo9OsIdyatIU3QaHyb7pdvGfp/ArhbP5ochHJPa1s
         Gnnh5l+I9C4sRvujiFKzOGG684shftQHfzVpZZ+iWJ482TBBgEJglSVg4z60GjUAMaRq
         1gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/Q3YSYugVmUu8idVs4rogRGpXXSgChV16OURtTKMZM=;
        b=i0UkncXyaMAwXtFeGJhok7ymv2mHoJS4axSHRpj3qFNRYD9gpjIKmA3TY5Q7FjJIJY
         MTg5p/ui5Ahko1zlA6GZb9ZmQnnZdyWxx2SbkgUaUOhQkLzpNOi/tOMTn6tq4hgqbKmI
         yGF16lh+RYjsaU003MDk45amwBJCmMgMSyjq+iC73WlbibCNT0SAUhzztpqZtzWWUlvw
         tdTIZC1MYYuXNgE/N94LeuBJ63e7zBmcXDHUPcue2M+3ZYH8qOvFg7EvZj7fm2qfGF82
         nrqvXMnk2h0kPd723WzmMfNbOUK408X4iIZjU30jUtff134xN/tpQuAC41ssoTbfA+Yt
         QRjg==
X-Gm-Message-State: AO0yUKXjcqIP4v/gmThJfmqCRNDl5opKhqsoufkjRyP3pC1MnFXGw7mm
        xLJiSX13hD7eock9GmTGiFQDXa1v5bPi8CYaX8Qk10I2mac=
X-Google-Smtp-Source: AK7set9RTs+UZHoF66KlG4VqpPF+SpnnLCtG5MFJ3SPOrvaISM5JkyUkoA6pinof8PasmoW/IR+DI2HhcEkJUKhxlPI=
X-Received: by 2002:a17:90a:ca88:b0:237:2516:f76a with SMTP id
 y8-20020a17090aca8800b002372516f76amr1401204pjt.2.1677222606827; Thu, 23 Feb
 2023 23:10:06 -0800 (PST)
MIME-Version: 1.0
From:   Dropify Drop <d.dropify@gmail.com>
Date:   Fri, 24 Feb 2023 12:39:55 +0530
Message-ID: <CAJxriS1Mjm2tunhsrLKsc6M21ed+sw22NT+dbp10KiBsA7isEw@mail.gmail.com>
Subject: Query if a TC program is attached
To:     bpf@vger.kernel.org
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

Hi, I am attaching an eBPF program to a TC clsacr qdisc both ingress &
egress to intercept traffic. The programs are pinned to ensure that
even if the associated userspace binary gets killed, eBPF programs
continue to run.

If the binary gets killed it is restarted and it gets the reference to
the pinned programs. But there is a possibility that during the time
it takes to relaunch, the qdisc these programs were attached to, goes
away. Lets say due to the network interface going down and coming up.
That means programs are loaded but not attached to the qdisc.

Is there a way to query if a program is attached to a qdisc? There is
an API bpf_tc_query() that can be used to query if any filter is
attached but not to query if a specific program is attached.

Thanks and regards,
Dominic
