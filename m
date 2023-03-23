Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC86C6007
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 07:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCWGyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCWGyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 02:54:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083602DE5A
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:54:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so82314949edb.11
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554449;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UtVIk9D2RLHAmhUlQpE1/FeIXV4obnQ/vMzRfLqvfrU=;
        b=VgU0qQA7reilICoLD0FDTYrzgiCWMkXXNvK1qu8csQvjBTOF0cz+ASW455E9S/smik
         QpbUa4F+bOov9KCz38FnFBjekwK2BNwi0SwHr76ED4TesiSFG2lGaOK4ePjGGHUa1GVb
         nUhb0dtS0nieDqJ9/lgqFWItxWZxDgB6XI79SU+XCcILT5bwLq+9kh5qQatVKj9X3wpE
         wtL2EaFSwruRevlKiLZTt7ZBRPwY2TG7HT24K6+mgEGR1jxT/xKCRTtrfWmCWsaxuzac
         IO7qnbBvWM4ylUqH7s+e6Vl/liGMc93YpsYUuOKIjWwZ0OFk4mslFBmh1A+UsDR3gRFt
         R12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679554449;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtVIk9D2RLHAmhUlQpE1/FeIXV4obnQ/vMzRfLqvfrU=;
        b=EJ1ZJoLNRT6fLDCK9IRSgmb6apHErKdZcFFNRGwr80M/aXiO4bFipvJ2CbllAtcQjs
         vGNc7SYjn6raJ9GfH5m0LG28/G5sytaMI9FQHdv94wK+VjB9f2+yevwA+K/TwwOiaV3l
         JewSe1Py311Uh6FH1qEJnblTKBdPyxur8laM2oQBog4HgosxfbC2iYfBvxrw//G3D8qz
         7OaTfZ7fuZzxpj0Ruz8Ve+byw9npeaMf7tRQdJwcMGk1vEi15awwiAKyOA0nS5BPXFEg
         +hnG7PgELpifk8qpjdgfVOdvcykgn+WLocGs/N1fNIQZIu6VdbfQZ/fWrfX6PJtWsIxE
         XthQ==
X-Gm-Message-State: AO0yUKXi/DjpkCYxWjubI4kYn3GRDOowttT5y+L9Iyeym/0z9bcumcp+
        dJjEFvS3VOkT9uGz3+DX4vYNORDgjBrIggNh3zFyAdvPrnM=
X-Google-Smtp-Source: AK7set+oV5zrSgLS0CeSbHbEqIcnKegdrfaPlAjZzlni4N4oBWvz4X+YiuinyvmtrK3xRzmttsfjt4aqTWGrrQDrOzU=
X-Received: by 2002:a17:906:3756:b0:930:310:abd1 with SMTP id
 e22-20020a170906375600b009300310abd1mr4374712ejc.12.1679554449200; Wed, 22
 Mar 2023 23:54:09 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5YiY55WF?= <fluency0726@gmail.com>
Date:   Thu, 23 Mar 2023 14:53:58 +0800
Message-ID: <CA+hefuS341OjUuWnxwVXj6QPMLcJLxvr+OREb_nEYrnt5kuBsQ@mail.gmail.com>
Subject: How to avoid race conditions in older kernel where spinlock is unavailable
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all

I'm developing an ebpf program to capture all descendant processes of
a specific process (e.g., a shell process), so I use kretprobe to
monitor the return of _do_fork() function in kernel. I maintained a
pid_map (BPF_MAP_TYPE_ARRAY) to store the PIDs of the descendant
processes and a ptr_map  (BPF_MAP_TYPE_ARRAY with only 1 element) as a
pointer which points to the first empty element in the pid_map.
Everytime the ebpf program is triggered, it will traverse all PIDs
stored in the pid_map to see whether the current process is a
descendant of the initial process, if so, the PID of the newly created
process will be added to the pid_map and the ptr_map is also updated.
Then I realized there are data races, because on an SMP system, ebpf
programs that run on different CPU cores may access the ptr_map
simultaneously. To solve this problem, I searched related docs and
found that spinlock is available in the newest kernel. However, I'm
working on 4.19 kernel which doesn't support spinlock, I wonder if
there is any synchronization mechanism that I can use to solve this
race condition. I'd be appreciate if anyone can help me :)

Thank you!

Chang Liu
