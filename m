Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE23A445EC
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfFMQsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 12:48:01 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:39167 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbfFMEwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 00:52:07 -0400
Received: by mail-qt1-f173.google.com with SMTP id i34so21095235qta.6
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mkHqDp2CTJ+vOF9HCOXwWdIQo3HXWuUgbgcL6XeYoU=;
        b=URngenUNvS0/DJyEUh+eLaC8X7i08PwL8R6mwzXSH7UaNIoql72Vqs/rDDcppsS0fK
         6S5Dk0gcyu7Ooa3VEzdn4jAVm/w1zKCQSJi2jgB2PDpd5e4o0nV8SfDMU6goXuUqT132
         Eg8/bYc6zgdUkSPBM8a5fI58tbh0/tcB0Pfgy+VFePDQ6lTO3ooDqBx0u3InvzarVJM1
         4lMqYt5ZaukzX0xAvcdaA3h7kY9fUD6fA2B1CJRb/HvARA7eJ1JasRCEZW3XxG9ZkPsp
         dD/0L54zxeIsOmleeBLBt1A4+IB+EN/vO8q51MQD6XoegkYPUV00eAshb60nvgJw6N49
         vP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mkHqDp2CTJ+vOF9HCOXwWdIQo3HXWuUgbgcL6XeYoU=;
        b=gROhV1Ihvqi5C932bJNrEJI++bsJ4VGzqNiGiHUhSGlEyCVPXI2+k6TsMZ7D/IiolU
         LI7qKU5gnVbbmiJJBnkzrl3bQvo2RZx4/0Q0Z7P9hPnUUfBZDJvJHXahpZVXQ4lYM2KE
         iu5Ac5ASeFNYrc2NNwUb5oNAzYs/AMOyh7fAZRLt3TWq2m4uUH9dQqo/6nUOSvOppFDg
         1yjMky+HAz0JMqE0w0nEpa3iu73xQxz+lCPbFgNTL4kBXkXcgL1QWGqTQbIb4WOf4O3T
         iIyn9Y7OVEcI/pCgNAYMPi0x1dtqeP290AUJW0Qou+y1Y+ZYeVLBeMl5czxpE8tg2WSG
         Dv+Q==
X-Gm-Message-State: APjAAAUUwV8b4e3YEPBUPgeNyySotxIOdP6EgYx7MdPjoCor9cGe8tm4
        8vUP9iRLAjB4eP6YyLZ2XjyrpT9CjeyR+5a0suQ=
X-Google-Smtp-Source: APXvYqx5HXLzVAfeEhRX03ZmrHJ0f0jmYS43pO2urQn1kGWl3FAO2VzqH9KaSCrNRIS/5YwI/YoGXvY8tqmlpUM1wUc=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr1812137qvh.78.1560401526310;
 Wed, 12 Jun 2019 21:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190612115145.GA26292@mwanda>
In-Reply-To: <20190612115145.GA26292@mwanda>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Jun 2019 21:51:55 -0700
Message-ID: <CAEf4BzZ8omK1g-nQFgHWtBsiE2=1p=T3LEEktxzC1Y6s2dhrZQ@mail.gmail.com>
Subject: Re: [bug report] libbpf: use negative fd to specify missing BTF
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 12, 2019 at 10:09 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Andrii Nakryiko,
>
> The patch fba01a0689a9: "libbpf: use negative fd to specify missing
> BTF" from May 29, 2019, leads to the following static checker warning:
>
>         ./tools/lib/bpf/libbpf.c:1757 bpf_object__create_maps()
>         warn: always true condition '(create_attr.btf_fd >= 0) => (0-u32max >= 0)'
>

Thanks for reporting this! I'll post a fix shortly.

> ./tools/lib/bpf/libbpf.c
>   1735                  if (obj->caps.name)
>   1736                          create_attr.name = map->name;
>   1737                  create_attr.map_ifindex = map->map_ifindex;
>   1738                  create_attr.map_type = def->type;
>   1739                  create_attr.map_flags = def->map_flags;
>   1740                  create_attr.key_size = def->key_size;
>   1741                  create_attr.value_size = def->value_size;
>   1742                  create_attr.max_entries = def->max_entries;
>   1743                  create_attr.btf_fd = -1;
>                         ^^^^^^^^^^^^^^^^^^^^^^^
> .btf_fd is a __u32
>
>   1744                  create_attr.btf_key_type_id = 0;
>   1745                  create_attr.btf_value_type_id = 0;
>   1746                  if (bpf_map_type__is_map_in_map(def->type) &&
>   1747                      map->inner_map_fd >= 0)
>   1748                          create_attr.inner_map_fd = map->inner_map_fd;
>   1749
>   1750                  if (obj->btf && !bpf_map_find_btf_info(map, obj->btf)) {
>   1751                          create_attr.btf_fd = btf__fd(obj->btf);
>   1752                          create_attr.btf_key_type_id = map->btf_key_type_id;
>   1753                          create_attr.btf_value_type_id = map->btf_value_type_id;
>   1754                  }
>   1755
>   1756                  *pfd = bpf_create_map_xattr(&create_attr);
>   1757                  if (*pfd < 0 && create_attr.btf_fd >= 0) {
>                                         ^^^^^^^^^^^^^^^^^^^^^^^
> Always true condition.
>
>   1758                          cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
>   1759                          pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
>   1760                                     map->name, cp, errno);
>   1761                          create_attr.btf_fd = -1;
>   1762                          create_attr.btf_key_type_id = 0;
>   1763                          create_attr.btf_value_type_id = 0;
>   1764                          map->btf_key_type_id = 0;
>   1765                          map->btf_value_type_id = 0;
>   1766                          *pfd = bpf_create_map_xattr(&create_attr);
>   1767                  }
>
> regards,
> dan carpenter
