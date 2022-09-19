Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316E5BCD62
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiISNhr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiISNhq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 09:37:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EE2DABD
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 06:37:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a14so31746016ljj.8
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=c3WOIiHtP14xtEN+rf1nb8AP+c6E3vUKvJN+gWYs+n2RFIddQC//iy+Su0bUUKNXu/
         wjNw7OJUkI45kXS/UWlH8qQQQTm9qbmqc/Vk7D861kaEI8q3c3+ywgDWlcHCjMWf+IDT
         c4sGz9ZsiQs1g3OCbAKZsBHYaAt5+PVEOpwqDbY+G8k7MywmpycfGNapcDrqK5IZAkCU
         7JmfVXwlSms7vY5lT1tOjEcdz3jCKPVRg8ajXrrsFetgPc/3GEYaABXiRInPq20DekmR
         b1aXQDo9boK3FZj0YbbyFqy2Urz4OrkUgedX9IOTvfjp3wQht4nZPR9APdEn1rhwNoXZ
         cXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cIcJSjmyj8wnG5VFs+JiL9G2kqKZBCT633VYrUKLe84=;
        b=46bOvNA06AvbgCH1FDc5mdaBSpM/RYK52To/8hV2+lIh37VJHUMkEYUcUP1C4xFJHV
         BSzznQBKJEu9f3OgoVaFeaLzPbdn+aVyanOugp2HydsN3Uxe7G2sWCefow/k/As7iPQL
         qtPRXE2LkMzMxJO4jtHpnIaT6116IiQPcwqGSz60bdpYAKdpvsELslYA+VgNPtO/ICOA
         8H9l07btFmbX3Z25JFfi/RL3EyjGKqdeubwv13QiZBSimxwyCZlndnKLQw7yT4GFrvhT
         zDrCtoLF9H6iZgwUc4fmH0xnUJxkgipgv947CjqO6EykxLLgsmypUxBfajfadnJ60E2o
         e4iA==
X-Gm-Message-State: ACrzQf0LrOx1Q/OnqQYJW30iks75/p1UibeItt6LttD0Qz+lkPznj0EX
        L0rZA3Rd24/U6rNg0wrHtQAiXM6hUmX2SwjlhZaST7x1UCs=
X-Google-Smtp-Source: AMsMyM4bIFqr3nB7llMQ3Plz1n9+dpYxYEz32D+kbLa5gwe5dASQEy3sv+q9n53N30/dyY8THTirxnYkVEz+YGvnUGs=
X-Received: by 2002:a05:651c:17a1:b0:26c:87c:c104 with SMTP id
 bn33-20020a05651c17a100b0026c087cc104mr5040422ljb.419.1663594663998; Mon, 19
 Sep 2022 06:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:58a:b0:163:f18c:8bcc with HTTP; Mon, 19 Sep 2022
 06:37:43 -0700 (PDT)
Reply-To: thomasjoyec@yahoo.com
From:   Joyce Thomas <thomasjoycetho12@gmail.com>
Date:   Mon, 19 Sep 2022 06:37:43 -0700
Message-ID: <CADijiqT786G5oLcDwqPOeVmBn5HhcVUaZrJ9neHLVQGm_FGTow@mail.gmail.com>
Subject: Hello Dearest one,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dearest one,
Good day to you today and how are you doing I hope all is well with
you; please did you receive the mail I sent to you since three days
ago?  Please can you be kindly get back to me  so that I will  know if
you received the mail I sent to you or not.
Best Regards,
Ms Joyce
