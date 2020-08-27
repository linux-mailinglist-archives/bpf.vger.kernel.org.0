Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E21254B15
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0QrX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH0QrV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 12:47:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C69C061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:47:21 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p191so3325625ybg.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=AOiqAxifN32NKYX+ysfh/1yGdi7pYwEY8haPfC2iBWI=;
        b=a83TsBTwga/TbC7S2S/wkZW+uKSL8DnMNUC5meGv8EjmMRUwIfIjBuGpTbeFk1yRAF
         kAHdIZTOmgF6ztkayOyYH2J+g0iJdJ9ZzP9HjnTS89LfcqOIZ08D2Vq8NbMWQBTWh/jh
         5OWwWvv0rBV2/6FWC0mBbhddicQtO553rIlWEV1oZP7V4tlZ2Mo7Kgyj4RK3jhxrT54U
         vtR7iTCThL4sK0sKkqWNbeTMSjPRLyp9NbcKFDxWpU6HtcNxyhCig/MxHHJs6XFqjb3x
         //9H39xqDnep6Kl/J7ZV1b/EdRRvGjMRrVCKgsMhQE1q+NOv/Had+DEh5MwTdmUDnk0/
         DNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=AOiqAxifN32NKYX+ysfh/1yGdi7pYwEY8haPfC2iBWI=;
        b=rPriNidJssyXeesvwgTCRlpk1X+OGSZOu39WsHtNEZkV3Ts3GIJEe5QqFmRjk6Edgj
         Uvcdsax5T1dR7i4sGLg1Ej66iMj+OjJSXYvPxCt+Sj9mets1dmmC0PYZiiv+j9wVjnZS
         5+jm/zIjZdZREGQ/myovF7bvCDG08JrrPfNs1iwh5sobGAOBgRi5aGUzU2e9cMhsV8TM
         pzbY7ZtFz3xtylBenYNT+UgOPx4macRzvadzfCAybtzCsYvlx+noZbQ/nScxwHyGjjWw
         LgB03pk93r9OA/3USjiiE+A4cP1wIws5yFHQzUQcS4Ljl+yJrHEusarIiUVvMqab3eSs
         pxuw==
X-Gm-Message-State: AOAM533MiR23GSG7UlsDDJjq6wXaqXNXD+fEBjBcakgDk9WBWSs/BQ6M
        MkGWqAS+7L9k+uHsLdYD3636NwbScCWtnQPjq5N1R3rgD/0weQ==
X-Google-Smtp-Source: ABdhPJzPIQC2VHMfiyxoHvq/GMyuLpXRQpIFxy4bxNm2oui48f0spkw3lk6s23zpNBWlRSaLrZZ0zrynR+Zz+lGsP0A=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr30883373ybt.58.1598546840508;
 Thu, 27 Aug 2020 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
 <b8a11771-7b7c-a3b1-0639-dc4706ef3ecf@gmail.com> <CAHhV9ERrtpmNdAmM0-evExLi=iC0wkwTByw5AqBbSQv9CbaNow@mail.gmail.com>
In-Reply-To: <CAHhV9ERrtpmNdAmM0-evExLi=iC0wkwTByw5AqBbSQv9CbaNow@mail.gmail.com>
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Thu, 27 Aug 2020 22:17:08 +0530
Message-ID: <CAHhV9ETSy-SRg5g+2RJWFY8jmcJ39mOAOxMJa=aTK+0VGJYNbA@mail.gmail.com>
Subject: Re: Frozen Maps
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you.

To confirm, is this the only way?

On Thu, Aug 27, 2020 at 10:13 PM Abhishek Vijeev
<abhishek.vijeev@gmail.com> wrote:
>
> Thank you.
>
> To confirm, is this the only way?
>
> On Thu, Aug 27, 2020, 9:54 PM David Ahern <dsahern@gmail.com> wrote:
>>
>> On 8/27/20 9:59 AM, Abhishek Vijeev wrote:
>> > Hi,
>> >
>> > From a user-space process, given a BPF map file descriptor, is it
>> > possible to determine whether the map is frozen (with BPF_MAP_FREEZE)?
>> >
>> > As far as I'm aware, the only way to retrieve information about BPF
>> > maps from file descriptors is to use BPF_OBJ_GET_INFO_BY_FD. However,
>> > I do not see a field which tells me whether a map is frozen (or not)
>> > in struct bpf_map_info
>> > (https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L4035).
>> > Kindly correct me if I'm wrong.
>> >
>> > Thank you,
>> > Abhishek Vijeev.
>> >
>>
>> fdinfo for the file has the frozen status (cat /proc/$pid/fdinfo/$fd)
