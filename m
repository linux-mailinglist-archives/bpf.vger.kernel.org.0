Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E644EBF
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLFWvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 17:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLFWvn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 17:51:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8534A078
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 14:51:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 140so15910425pfz.6
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUncIJZdU3nK+S56v04n1fL0wk5o09HIUop9m+sJlw0=;
        b=KCE2zO6WNGzf3yEIA1kux+zo1nW27TLp92iRh/dPKdvOZQ5vjFtjBb5EueG2bhihV+
         zh5QunEVtbIOtbScWf/RNta3+l4QrtzP/vM6YwjqwDjYy6jqw1x7LRzhyoH3WHnE+YjF
         MiQwtpMrw74Ydp+9+9VdILT+Wh+ToPbNiT7RR2M711doeBOyBTfBwk7Fd2dsve+InNmN
         clnJ74mLhrgnlF4s8QPHoTtibjRhHXX7TXwobGjYUgWp6fPTHnh5FJRVZ2kzNVq0N9OU
         5AeoUS8k6I2vRTqlLBlUB/vVm8zJblwAOMrslWf//wR1UO9uVaupfApokSCi7g8zle0/
         K/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUncIJZdU3nK+S56v04n1fL0wk5o09HIUop9m+sJlw0=;
        b=HN7h45NJRRnNcX2DZsYi0WHfXsvCgPvMULdS+Qyhf42LzVillRptwWmdJ5AiOOhNqt
         a96Hynf+jExTdw326h7/wO9qmZYy6ZDtrwaRRpgpOwWOxUx+QXsa+7H3Y3vjtctbhHkq
         BTsIs6Ju3HmkinEdJ2ES+Cwa4N4vjTGmn4UDZhwU4rApy2JozU+XEG2tltXpKSgKwPny
         qGJSMnuy4Egm68CrVqPB4PbNwARw3t/oiLw9C4rKggnpPCrWlyymHnzu5oLvkg2Y+SiX
         gNmqrTERd+ObKaMC4+qFyuAmGZurTcvD9pZLe3efwlPasRZtZ7srSzhmC7XhDJ7BnhBd
         ayLA==
X-Gm-Message-State: ANoB5pmwq8SWV3sd7KCsY55g2F2hXrN2HEfWgHK6+MaFa2yJzrk0eQjf
        f5QD7eNXX12SjbHuioMbmUc+eDpk6ab1rhEpHDk/
X-Google-Smtp-Source: AA0mqf6adAzEF0ChixzTkY0x4g0CgQ1STvfi2SsvCkZO8jfjhkcWv0MJGFg1ZegGwq434nKkRrAWwbyAt2VvhoilfBM=
X-Received: by 2002:a62:1616:0:b0:576:af2d:4c5f with SMTP id
 22-20020a621616000000b00576af2d4c5fmr15934390pfw.23.1670367098777; Tue, 06
 Dec 2022 14:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com> <20221128144240.210110-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221128144240.210110-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 17:51:27 -0500
Message-ID: <CAHC9VhTuEH83tcA-Je7NMkxF8a1W=Bg+oLhLYeASKp70VqAy4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that if all LSMs return a positive value
> __vm_enough_memory() will be called with cap_sys_admin set. If at least one
> LSM returns 0 or negative, it will be called with cap_sys_admin cleared.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks Roberto.  Normally I don't like merging patches this close to
the merge window, but as this is a comment-only fix that makes an
important clarification I'm going to make an exception here and merge
it into lsm/next.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2831efebde69..c35e260efd8c 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1398,7 +1398,11 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by the LSM infrastructure to the
> + *     caller. If all LSMs return a positive value, __vm_enough_memory() will
> + *     be called with cap_sys_admin set. If at least one LSM returns 0 or
> + *     negative, __vm_enough_memory() will be called with cap_sys_admin
> + *     cleared.
>   *
>   * @ismaclabel:
>   *     Check if the extended attribute specified by @name
> --
> 2.25.1

-- 
paul-moore.com
