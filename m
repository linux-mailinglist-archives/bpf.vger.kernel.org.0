Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907876D702F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 00:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDDWd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjDDWd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 18:33:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA55113
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 15:33:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fi11so13013205edb.10
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680647633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFjJTFlkjW54kUOOYNHqlXkwvf3bK1+zTG09/BAVOIk=;
        b=aXeDTGS8vDXCkDmHROiHFNo+BP+M71XabdmRO775qzO/Ik1N4QeaLb86hzrFRtx4IS
         gFzA1CowctSdjnwHvn8IMxgEH42cmtQzBwhW8QIj5a0KpB75VxN5Ln6oeFl9QNCgPW2A
         YdFea7nHVDwSeh/AuDk2MIyZyAtkd/5NqgTzdmAZ688N0ms5DSOZD5VpUvNVFlIZj9/i
         Ax9KhHJ1gHLfI7c1v0Xk2fQrpEkmOc36H2DNi0mHs44YqynNEU6NPW623jYatsRihHVo
         rZF8EQrFATz2BAw/wVk+UtelInn0xyogSWS37rDdoyrZ9tYKcQXAkpAHG+nUr0lBcQZp
         52Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFjJTFlkjW54kUOOYNHqlXkwvf3bK1+zTG09/BAVOIk=;
        b=079frD4YVLgMm5Y5yCJbZ0/cn9if13OPD05V0bjClB0FsxdfvDYeiLevTw7NjVz//Q
         7JMScG62JbymenA56n/O5KpH8cCLu/dqs/oq8o9i6Sl+R5mqU/JO9Y417N78Ch77DxId
         pgtixbfTJ14cPtHcBIlH2KB4Q0Z9d1pgaRTrR6WVriHvn7PiMChgd+xy0cOLZC2W4yBF
         HGEk3oFETu7xCFADCN5eFBn0CoT8U0KEEwI7rjpmLUHeEQboal9iaR9LtynEN9jETBGS
         0HXxJTJZr/WcmPeeUVZPY/9JMsBbsGfOoUpDM5Pijg6BdcUMW1EIAsVBP3aLX/+Z8Qfr
         jiGg==
X-Gm-Message-State: AAQBX9c6MbbkKBKiUPE9d6oQVR1ZbCf0aAuI3LZtrIMlJZRow+52ifQs
        eojIvqOObo+MQk7rE0MX8vnNQdLrILVNtF+1Oq77HiNwU9Q=
X-Google-Smtp-Source: AKy350ZXR/E2mYwzhHlVy6irer4Q9M7xZe9qEvRRmyAqeXJbklipTgtCZWIDVyJ7ng6M2PEGerechgnQ3QM5a6QtgiE=
X-Received: by 2002:a17:906:25d9:b0:931:fb3c:f88d with SMTP id
 n25-20020a17090625d900b00931fb3cf88dmr571784ejb.5.1680647633110; Tue, 04 Apr
 2023 15:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQdkDuC9Cu2tvy1nnnaDvEhuE7c68KUUr+t8xi5BzipKis8_g@mail.gmail.com>
In-Reply-To: <CAGQdkDuC9Cu2tvy1nnnaDvEhuE7c68KUUr+t8xi5BzipKis8_g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 15:33:41 -0700
Message-ID: <CAEf4BzZvDfyYQb+h09V-PAgc_5mT-TKVH0uqNiJL6y0eoFcBHQ@mail.gmail.com>
Subject: Re: [QUESTION] BPF trampoline limits
To:     andrea terzolo <andreaterzolo3@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 4:32=E2=80=AFAM andrea terzolo <andreaterzolo3@gmai=
l.com> wrote:
>
> Hello! If I can I would like to ask one question about the BPF
> trampoline. Reading the description of this commit [0] I noticed the
> following statement:
>
> - Detach of a BPF program from the trampoline should not fail. To avoid m=
emory
> allocation in detach path the half of the page is used as a reserve and f=
lipped
> after each attach/detach. 2k bytes is enough to call 40+ BPF programs dir=
ectly
> which is enough for BPF tracing use cases. This limit can be increased in=
 the
> future.
>
> Looking at the kernel code, I found only this limit
> BPF_MAX_TRAMP_LINKS. If I understood correctly, this limit denies us
> the use of the same trampoline for more than 38 bpf programs. So my
> question is, does the commit description refer to another limit or
> does this "call 40+ BPF programs" refer to the BPF_MAX_TRAMP_LINKS
> macro?

No, it's BPF_MAX_TRAMP_LINKS, which got reduced a bit down from its
40+ limit to current 38.


>
> Thank you in advance for your time,
> Andrea
>
> 0: https://github.com/torvalds/linux/commit/fec56f5890d93fc2ed74166c397dc=
186b1c25951
