Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9E4BF48C
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiBVJUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 04:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBVJUL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 04:20:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58C149BA3
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 01:19:43 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t4-20020a17090a3b4400b001bc40b548f9so1837391pjf.0
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eH8WIdOj5Woq88qVAFgU9dGdxdX8fEiqJyOT99bEyYk=;
        b=MehL0wRxVfbAj73UNl4pP3kmP2psSnS8Xl/hVjPYdX5WU9Ljxb4MMXUhJF5uMvINKB
         8uNlywq680oergZvDaFDPOeqSHbIVK3OVQfEzkhpw7uWCCbxZkF8wlLEPUIs2yij3SSd
         fVN1uZ8la2y03opjCIGnMFRDOktis1YYJVjDde1h0trmuWy5/bdFF9c1XWHkMTmKv9jc
         1Yz0rh2d85d95Tn/v5pRp4uHEd49ei6SaZ2rGVQJl/dFcuQQl/IIhW0FlWdrRm5LW1P6
         y7WON6ymiZZc1fF3vWp5rb0ajyrve0Y9gIT0DrFkyU3HtKSCpID6NhAqjOpF4ZmtcEGi
         +tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eH8WIdOj5Woq88qVAFgU9dGdxdX8fEiqJyOT99bEyYk=;
        b=joLIOyyc9aaOo14KOkP/84cuVv1A2TpLJnQOvYQA6eY1c1xAPE6p+AbBoWrci31d2p
         XhZFL6nDBur5B5SE+8XaNxGcAzsXdO1bolfDBuUoyGo4U0hwlK0gph9NpHTMdk19ItHy
         AwNvxOeu886J6aYLavAQ0QpJPDGXEhJ4f+cTZrl7FoCd+iaGbT8TW4s1SKQpQys1a3J8
         Fmv5zLlm35j3lixdDv3OF6PI4Ec1g6k6u/muMitDUd6kH3SeTGmDaiM4hJay7XbsmVwO
         4A1YyXvvubmrKVfY3vByNh5BCIDPXnS00rYSFfzEvz0any0OSTKqHLO+JmetEHuVR3Nj
         T//Q==
X-Gm-Message-State: AOAM5309Xm6+wvQwjwmIOPOrwsDQVmPVqxsvTbxI8X2cxoCmUS6KX1s5
        oAHEEcv4HUbmTpMcBO8CNhOzEvmeYjKmzNC2tX+ShyuIvQolig==
X-Google-Smtp-Source: ABdhPJwlQnLfDm5+MLv5fjzsKH30Klj15jjwyksbyhtm9YnKJOELC3xsddDAO2OLpzqWpSU2g3zYBnlPsygIRptGI+U=
X-Received: by 2002:a17:90a:7f03:b0:1b8:8d90:b194 with SMTP id
 k3-20020a17090a7f0300b001b88d90b194mr3208090pjl.2.1645521582971; Tue, 22 Feb
 2022 01:19:42 -0800 (PST)
MIME-Version: 1.0
References: <CAKXe6S+B9+uH3R4qiNx68yZwX32iaAC6g92x7jS9JodNRjaAyg@mail.gmail.com>
 <565e2bb0-2f42-cbb4-f63a-40723ee16414@fb.com>
In-Reply-To: <565e2bb0-2f42-cbb4-f63a-40723ee16414@fb.com>
From:   Li Qiang <liq3ea@gmail.com>
Date:   Tue, 22 Feb 2022 17:19:06 +0800
Message-ID: <CAKXe6SKcxOQwVPCFzmzHf46z+sTR25tayb3rp0C3kHG3rA_8DA@mail.gmail.com>
Subject: Re: How to get the device number of 'bpf_get_ns_current_pid_tgid' helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=BA=8C 14:24=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2/21/22 7:43 PM, Li Qiang wrote:
> > Hello all,
> >
> > As we know, to call 'bpf_get_ns_current_pid_tgid' helper we need dev
> > and inode number. The inode number is quite easy to get by 'ls -lh
> > /proc/xx/ns/'. So how can we get the device number easily in practice?
> > the kernel test just uses 0 to test.
>
> You can use the following command inside the namespace to
> get the dev number and inode number.
>

Thanks Yonghong, this just remind me to look the stat syscall and it
also contains the device info.



> $ stat -L /proc/self/ns/pid
>    File: /proc/self/ns/pid
>    Size: 0               Blocks: 0          IO Block: 4096   regular
> empty file
> Device: 4h/4d   Inode: 4026531836  Links: 1
> Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-21 22:22:48.782383342 -0800
> Modify: 2022-02-21 22:22:48.782383342 -0800
> Change: 2022-02-21 22:22:48.782383342 -0800
>   Birth: -
>
>
> >
> > Thanks,
> > Li Qiang
