Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EDF68D00D
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 08:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBGHDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 02:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGHDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 02:03:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C9CC2A
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 23:02:44 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w3so15716356qts.7
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 23:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLc/Voxttk0K0bVFTOEyEs7YtG6EdmZ9JU6ezjA/V4E=;
        b=XUcOiTKoLp7N8D5HWAZ0RVmAkrdVGzS0olVQfGxJdZqDmJxrYBAP6uuzXwIybTMdX+
         dcqAZ9HBuqk5381R729H63bu3mTie3wDs4Lqc8yO4LdMuy9VocZ2kjxnBYftu66W/Bd9
         AZ0yOkgl/dUkRAL8j1pgIc/QTUsGFqSG3F7323KG7R6Z0zddKr5VJJt0IOUr93mWlW84
         83hM4YCqBhcAPSrsKNIzGj+Gszxu6R4quNA9H6t3MIutRKQFU4B7Xpsu9BubJ8Q2skDT
         Mr6VTnpGrNemQP3OZWjlcMZU+EG2Rc/8S8A/N3uN/pqzgwZPYbX+Avuro39+HPfAJAWa
         ayCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLc/Voxttk0K0bVFTOEyEs7YtG6EdmZ9JU6ezjA/V4E=;
        b=Ai0bzxyk299ObZRkToJHD0HAVZWPf1SYT5Vd7xCzygdw/INynG/vuYJFd6LzqdD+aX
         QFY3JG2rsPe6ofKjNlj+5/l3Az+aYVU7zuTQL3IUqeTxSr+jZA5Ivo8CB30pAOjbIeuY
         m8ZXCbntggZ3eJjtqoGxKDm5YjUCff/uQ7jakS+50zYJfB0eLf0O8XzwTgSTRuH9NlzM
         W13XIU4kcEO/h2rArUo0NL8qGQYhW4PdCDy94uz5IIplmYJb8pFgbumj+ay8lmNnqJNO
         zZWDsL44wtPSMK2UuQlT9+pe9VbXJRlGNV8oCYLlz6ZwWpOA5YHeEEOukixF3MNiyhew
         JcVw==
X-Gm-Message-State: AO0yUKUUQYIDlBOA4ztR00JlrPHjmvlutrwfncRAAGrkR3VbfJjuzg2S
        4NVOLXj8Fhn9IZRM8YUxCy+S1xNxlJmpDolStz4=
X-Google-Smtp-Source: AK7set+WOA8AnDxtDT4nbRZMQ4Wlm75cF5E3fHaSldoIhx1lTXHU43C7MRy15kUBNDtFlHQMFCY5a3w/YvSV+VYFV7c=
X-Received: by 2002:a05:622a:50c:b0:3b9:a6ca:a603 with SMTP id
 l12-20020a05622a050c00b003b9a6caa603mr384493qtx.101.1675753363188; Mon, 06
 Feb 2023 23:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <63ddbfd9ae610_6bb1520861@john.notmuch>
 <CALOAHbAjHqXGZH_p19aYTbqK=sE8ZaMxhVzAoTO4ZKSXLiyx-w@mail.gmail.com> <CAOfppAUgB1qtFQfSb7WnGTJ+0fP2NL_T9EJYHgwQyW0mx4vnXA@mail.gmail.com>
In-Reply-To: <CAOfppAUgB1qtFQfSb7WnGTJ+0fP2NL_T9EJYHgwQyW0mx4vnXA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 7 Feb 2023 15:02:07 +0800
Message-ID: <CALOAHbBiQ28rCHzhEsWQ7vs89nsY0W5sMNSc6YDerd19z7ddvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] bpf, mm: bpf memory usage
To:     Ho-Ren Chuang <horenc@vt.edu>
Cc:     John Fastabend <john.fastabend@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        hao.xiang@bytedance.com, yifeima@bytedance.com,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        horenchuang@bytedance.com
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

On Tue, Feb 7, 2023 at 8:49 AM Ho-Ren Chuang <horenc@vt.edu> wrote:
>
> Hi Yafang and everyone,
>
> We've proposed very similar features at https://lore.kernel.org/bpf/CAAYibXgiCOOEY9NvLXbY4ve7pH8xWrZjnczrj6SHy3x_TtOU1g@mail.gmail.com/#t
>

I have looked through your patchset. Maybe we can use max_entires  to
show the used_enties for preallocated hashtab?  Because for the
preallocated hashtab, the memory is already allocated, so it doesn't
matter how many entries it is using now. Then we can avoid the runtime
overhead which Alexei is worried about.

>
> We are very excited seeing we are not the only ones eager to have this feature upstream to monitor eBPF map's actual usage. This shows the need for having such an ability in eBPF.
>

Happy to hear that this feature could help you.
I think over time there will be more users who want to monitor the bpf
memory usage :)

>
> Regarding the use cases please also check https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com/#t . We are developing an app to monitor memory footprints used by eBPF programs/maps similar to Linux `top` command.
>
>
> Thank you,
>

-- 
Regards
Yafang
