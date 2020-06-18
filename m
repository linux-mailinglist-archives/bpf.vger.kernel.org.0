Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB41FFD09
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 23:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgFRVBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgFRVBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 17:01:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59CC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 14:01:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so7049353qkh.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=401cejwJDHVTFNFxKCBUQdn9/o99cqTleeflC4uOmes=;
        b=aS6JTqsYXUUaotZw2AdgQcrsJ98JWhOuKsJGPsbVL3S4fd+XF9KKdP8URY5S9mMoSY
         SBkowrh6yC0hYdxPnhi7Q5VzojxucppVie9al32cpw8kjbaPvRiwVHF1f5hVzj4pFCGA
         /xp89vBO2OMmGWCPjL1uOvcbii7FjtZW/Jd0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=401cejwJDHVTFNFxKCBUQdn9/o99cqTleeflC4uOmes=;
        b=BlYFiwgjttQeWSvEfDcHWDEc5cGU+/+N+ctysR90JCPOh7L7lguYhcTfxMChJP4FpW
         PLaR0h7kp0R2WGe+0yBUZxsj48EsDjQ7qNt1fYjdmHOBSEAo7/dDrn0UhX00Iw2di4lN
         0eE6YJ3F91GAZXQXFcCadVu2QML/HRhqfQb+LZws6CnONsRR1JazSYVvkX3VWBkvTwcQ
         Z0gspcLMwTGFP6qDVRvV176AuNNM1ngfOoPMXCeT8upWWxbmSE3KMjjFD0jcydL0jmYc
         qWryj7eVcPerWPVOA2bzt2bXRkxFshJuGfykoCHg+HiRDelU74BhpHp3B1t8jnlig7PX
         5bHA==
X-Gm-Message-State: AOAM533OZU3JcwJXLDyJckpveIX/5vz6wab40z44tBfsPMHCOfV283yj
        K1oJ/sejblPS2J/UFxuyg3y9tJ6553g=
X-Google-Smtp-Source: ABdhPJxUl7Rwgtp3ojd5rdGKufCTKokE07OaxJe8gC4bfQyQyex7MmQFWpiQF51scjjA+lOChCiJTQ==
X-Received: by 2002:a37:5ac3:: with SMTP id o186mr327076qkb.272.1592514079724;
        Thu, 18 Jun 2020 14:01:19 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c2sm3947134qkl.58.2020.06.18.14.01.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:01:19 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b15so3800076ybg.12
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 14:01:18 -0700 (PDT)
X-Received: by 2002:a25:9843:: with SMTP id k3mr862095ybo.444.1592514078217;
 Thu, 18 Jun 2020 14:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200618142714.GA202183@mwanda>
In-Reply-To: <20200618142714.GA202183@mwanda>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Jun 2020 14:01:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJVxSQnqxTsguKFv_rX1vW87jSMeU9HDue-97qYYK82qw@mail.gmail.com>
Message-ID: <CAGXu5jJVxSQnqxTsguKFv_rX1vW87jSMeU9HDue-97qYYK82qw@mail.gmail.com>
Subject: Re: [bug report] seccomp: Add find_notification helper
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 7:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [ Kees, why am I getting tons and tons of these warnings?  Are we not
>   going to initialize things manually any more? ]

We are, yes. This is "just" a bug.

>
> Hello Sargun Dhillon,
>
> The patch 186f03857c48: "seccomp: Add find_notification helper" from
> Jun 1, 2020, leads to the following static checker warning:
>
>         kernel/seccomp.c:1124 seccomp_notify_recv()
>         error: uninitialized symbol 'knotif'.

Thanks for the heads-up! This was also reported by the ClangBuiltLinux
project, and I've since fixed it. It should be visible in my
for-next/seccomp tree now.

-Kees

>
> kernel/seccomp.c
>   1091  static long seccomp_notify_recv(struct seccomp_filter *filter,
>   1092                                  void __user *buf)
>   1093  {
>   1094          struct seccomp_knotif *knotif, *cur;
>                                        ^^^^^^
> This used to be initialized to NULL here.
>
>   1095          struct seccomp_notif unotif;
>   1096          ssize_t ret;
>   1097
>   1098          /* Verify that we're not given garbage to keep struct extensible. */
>   1099          ret = check_zeroed_user(buf, sizeof(unotif));
>   1100          if (ret < 0)
>   1101                  return ret;
>   1102          if (!ret)
>   1103                  return -EINVAL;
>   1104
>   1105          memset(&unotif, 0, sizeof(unotif));
>   1106
>   1107          ret = down_interruptible(&filter->notif->request);
>   1108          if (ret < 0)
>   1109                  return ret;
>   1110
>   1111          mutex_lock(&filter->notify_lock);
>   1112          list_for_each_entry(cur, &filter->notif->notifications, list) {
>   1113                  if (cur->state == SECCOMP_NOTIFY_INIT) {
>   1114                          knotif = cur;
>                                 ^^^^^^^^^^^^
>
>   1115                          break;
>   1116                  }
>   1117          }
>   1118
>   1119          /*
>   1120           * If we didn't find a notification, it could be that the task was
>   1121           * interrupted by a fatal signal between the time we were woken and
>   1122           * when we were able to acquire the rw lock.
>   1123           */
>   1124          if (!knotif) {
>                      ^^^^^^
> But now it's uninitialized.
>
>   1125                  ret = -ENOENT;
>   1126                  goto out;
>   1127          }
>   1128
>   1129          unotif.id = knotif->id;
>
> regards,
> dan carpenter



-- 
Kees Cook

-- 
Kees Cook
