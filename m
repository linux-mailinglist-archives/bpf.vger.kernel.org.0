Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9D1C657E
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEFB2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 21:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728609AbgEFB2z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 May 2020 21:28:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB94C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 18:28:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f18so552932lja.13
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76OtenGWAkSDUJEhLpkCek93MkRcPxXTbg0Sd3kqU9Q=;
        b=llRy4LTG3ab/lk6swDQC1la+cYHFSg133H9CpXMSVMeOr5VwQO5sAtLB0HcYpnhLJj
         +WKljabFc2WgUU9hpKaCZBuG82q5WJwfZ7bHFWe6eygGCantbbBsFCvtNCGFFUWOotX4
         j96LZryxQXd8s3e9mtUxYsiwRlk4lSN25i8osVS7ryWouWCEUeaj56leUxzb0TaMcyXK
         4QiJI12OuEfX8nepdgN8cVWGDQfHRAzFYIxEyAWT9P99b0BZpzp6OhrOpog3R2PyHapD
         nsQu9Taa4QYoNVicZQ34il/20GpkC7yjzyTwLpxRYuJ8gQlWZUn1Vin3fHGQ+9RgTJIF
         7ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76OtenGWAkSDUJEhLpkCek93MkRcPxXTbg0Sd3kqU9Q=;
        b=nvrl5ArrvwRYZgUvos1h/PvcI+ZMlnyPJdbq3x06h1mBjrRB5i1uv4Hly5a5oFMNLg
         JZvUZ1uRpdqP56HJ/n3BD56P7iWYlHJclKYHsGN36blC1NcGzlZ3TrJ9rtxspExPMnz6
         qXqAmzpBXj5RDhHHSMYcctw1KV+RUPhAMzV7ug24T7MNcdeI1TP6vrLKuJ508lAAgIWK
         D7gPD6uf/07fy6H7AVZchu5lKa1YYcr6UIh7kQN5eovJpLVI7vPxiczkVP5nmc8Ev4gC
         MjgZOLuxMAeq8hOWkaDVnQW2abFuIk4mywTvHlB6N7zKX6mOPDxRjh1QWWsP+PZSu8NA
         Tl2g==
X-Gm-Message-State: AGi0PuZuIdLuUFIbjyuofzAUOz2oo5YvL7RdT/CnPuJQv8jr6xoInHCj
        HVDFq05tpvwnoTl2oG/g47HOUXcT1mO7jH2wG8Y=
X-Google-Smtp-Source: APiQypLcnnXMl0Z+H3hJ1JWH0v+st7MclJWLk4ZZP0Lph4Ze3BwD3+bUyp9IY7RDxA2tx2PCW5p7IrB5WbJvcwxrN2E=
X-Received: by 2002:a2e:9011:: with SMTP id h17mr3561792ljg.138.1588728531943;
 Tue, 05 May 2020 18:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
In-Reply-To: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 May 2020 18:28:40 -0700
Message-ID: <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 4, 2020 at 9:12 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> In our TC classifier cls_redirect [1], we use the following sequence
> of helper calls to
> decapsulate a GUE (basically IP + UDP + custom header) encapsulated packet:
>
>   skb_adjust_room(skb, -encap_len,
> BPF_ADJ_ROOM_MAC, BPF_F_ADJ_ROOM_FIXED_GSO)
>   bpf_redirect(skb->ifindex, BPF_F_INGRESS)
>
> It seems like some checksums of the inner headers are not validated in
> this case.
> For example, a TCP SYN packet with invalid TCP checksum is still accepted by the
> network stack and elicits a SYN ACK.
>
> Is this known but undocumented behaviour or a bug? In either case, is
> there a work
> around I'm not aware of?

I thought inner and outer csums are covered by different flags and driver
suppose to set the right one depending on level of in-hw checking it did.
