Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84690101246
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 04:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKSDxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 22:53:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36979 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKSDxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 22:53:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so15764918lfp.4
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 19:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4nF9d8UE+rC09oac5YKFRIXUcvh2UUec4cIY6JmoV0=;
        b=sUjwRho5m3JcI69pddih/EL2hNB4b4pSyZqY0YYPphAnrq5rOl52lpezxHbJ0XqwRk
         CEeG9cuyRWYUQnO7rUvUhGOsIJZkQkAxrIBdgSrh6CdQ6WWE9pytH+SMghLxOXbCQm2G
         e9sxz2WEmCRrZi6v7Z80VTd479I1HIwuMfPnwtMsYiNSSUCP9QtJOeMGB5lZA3FKNPbW
         Ca4j1o3H6RYIYXxU13Ppxc5IkFRY5tObsnbFRQlF3s/UeGpEFGIZmLtnaQ99MEtlfqoi
         lFsZEM14JySR5HKO9H4Dh6qEP7aQ8A+W82gkaxXMhiaqfaVxvmHyTiujwYmhw4aRNmOw
         neDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4nF9d8UE+rC09oac5YKFRIXUcvh2UUec4cIY6JmoV0=;
        b=IIOHEZd5QcgPnPqSblUR9kp1YurQg2H3dpwF6a45MS2kLeqguuhCE/Y9fhCdX0KY8v
         22HSqECs4a56bqnCJR7m11o94cfUtY1ExtQ0Go7VPyhcG4hrNkuE/qpxUROI0MGYCOUq
         M53+m+xH7wuchlr+J1cPWiXp1qYEB3fu8dCcqWqHui3ZYKOmOFTItsoNYRD5Agi43AgX
         Ci3A6UdpQ2d0jOAH0Puc+PNm5kVs4eRRnqd7msBgc1+q6/SdUl1MU8Q1gHsWd+lP9lbD
         Mu5x/87ksW3vOz8QBELRag+Q6aSeE3kfEER2j/d2buxJA8NnhU7oQY1LgKHIIWr3ljnJ
         DGAg==
X-Gm-Message-State: APjAAAXIM/3Pp/6xVXH4tof53U0Tm5XvU0YcIlJ4wTvG88Oe2F+7/b7f
        wP06axjLAbhzNRe6gttsz81UylFRfS2d8Q6KbFw=
X-Google-Smtp-Source: APXvYqyZt4jtxrIdEazqq098uHt0HsN6ivBkIHZy9xgalecz9C1SQ7V1+nfi2UdesSY/vjO6syEFklzFDMaLAQoj4Ws=
X-Received: by 2002:a19:6e06:: with SMTP id j6mr1913303lfc.6.1574135631400;
 Mon, 18 Nov 2019 19:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20191118180340.68373-1-iii@linux.ibm.com>
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 18 Nov 2019 19:53:40 -0800
Message-ID: <CAADnVQ+bcx_3O122b9LUHsVUyM3BVr+UgO4fYREn_cOF_GdxMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] s390/bpf: remove JITed image size limitations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 18, 2019 at 10:03 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> This patch series introduces usage of relative long jumps and loads in
> order to lift 64/512k size limits on JITed BPF programs on s390.
>
> Patch 1 introduces long relative branches.
> Patch 2 changes the way literal pool is arranged in order to be
> compatible with long relative loads.
> Patch 3 changes the way literal pool base register is loaded for large
> programs.
> Patch 4 replaces regular loads with long relative loads where they are
> totally superior.
> Patch 5 introduces long relative loads as an alternative way to load
> constants in large programs. Regular loads are kept and still used for
> small programs.
> Patch 6 removes the size limit check.

Applied. Thanks
