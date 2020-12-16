Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F52DB8A9
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 02:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLPB4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 20:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLPB4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 20:56:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3EC061793
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 17:55:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq13so623489pjb.3
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 17:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOnaNx+FOjfjzTvevCJ8dWeetPW4iWtEiTISdNYyoT4=;
        b=kG4PvUiAFncGD79/MeEKZE6xSsCDcSx90v0/hfbdMJp5bnUkkL5iWMUI28oEvN/FyI
         Ml15x0ryjDID03W8KAJ9tBP3d1gmjIn2LEJyak7REgnhUe0sRq3vnC1qdVPRXD8szhgB
         Cq2XT9wPCjG4CENMvvY9oFlPQAdlrv45AvVLw5huCVEyY3lw0MXRAzvEXffmvgJmJi8C
         ZV1/RKnpHJvFi/vP+BVa4iG13v20/cvfvpWYdsBtZXDHEVk1GPNIUbSB+DK+/HbeWHdd
         ZP8fFR10h+UczG3CS6cmDhr59FvCOTTT+YLjnVLCpOPyBqinS/btOLXDOfbs6FmRsu88
         T/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOnaNx+FOjfjzTvevCJ8dWeetPW4iWtEiTISdNYyoT4=;
        b=fSldsXywy6sepGNrbqK8OjvFiVOF3F80i5/NyemWyIKNLEmYs3dQl3w8Rr+wzZfZGk
         Hw/88pyrAulJ6UfWBmByxjC5FRfSNMeJYeM0GHWxxFatFm59yHNR8oEv0OrSvvndR7oL
         0sO9vgGxEraoSMiwrmSDR2SEvXN3pUfPROZhXjxrsirqsg5YvLB7C62d7WU65QBRCa/Z
         15xYosfDLiP1NWj4bX2rPgCrrHnhaTbzezcY3CkbCDMs/qHMHu2kJMypDlDoBgVaH9Xq
         q9WnmnPXhB7bj3lJwaRVLYImONh1dHKNF5soyWttJ7w5UAX+2Op6t+rpOnMy6tnhRbxh
         q2cw==
X-Gm-Message-State: AOAM532sslTOByA7x7dctXSYridy4C21xz1O+rf6NJrrKFJ4ffjlQFHc
        hNg51W/KzE5dX5uISr75sRE5Gs03cX9wCj7J9hk=
X-Google-Smtp-Source: ABdhPJw0PsvXssdcQGynJELc29ATHocsnk2gk9SGrvog6d9T6A5MlDwc8m+JZQ4KxdwDK0Mhy5+/i9NhlYIsbxjRD7M=
X-Received: by 2002:a17:902:9302:b029:da:f6b0:643a with SMTP id
 bc2-20020a1709029302b02900daf6b0643amr29593394plb.33.1608083744178; Tue, 15
 Dec 2020 17:55:44 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
 <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com>
In-Reply-To: <CAADnVQJOCGQanyw2qfG4gxEw3FHQ0oSUbSeAk2WTuZ+mnwVk5Q@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 15 Dec 2020 17:55:33 -0800
Message-ID: <CAM_iQpX8HU1RPHb+vXRH2qqFLETOJHR91dNxjN-y88v-bcNh+Q@mail.gmail.com>
Subject: Re: Why n_buckets is at least max_entries?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 5:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hello,
> >
> > Any reason why we allocate at least max_entries of buckets of a hash map?
> >
> >  466
> >  467         /* hash table size must be power of 2 */
> >  468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
>
> because hashmap performance matters a lot.

Unless you believe hash is perfect, there is always conflict no matter
how many buckets we have.

Other hashmap implementations also care about performance, but none
of them allocates the number of buckets in this aggressive way. In some
particular cases, for instance max_entries=1025, we end up having almost
buckets twice of max_entries.

Thanks.
