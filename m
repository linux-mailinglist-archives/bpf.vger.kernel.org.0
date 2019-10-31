Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8FEB615
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2019 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfJaR0x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 31 Oct 2019 13:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbfJaR0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 13:26:53 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37DE9368E6
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 17:26:52 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id l9so1095107lja.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 10:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JLzbdaabISuNZoZjrluwYnkeJoHu1ZdffdLyPysBpIc=;
        b=Fg0JQbUVO/prXoiCCKnUFIzoESL5bWzt6AeC9957066f1QFZQXsf1RI7mdNshIcH9R
         HZDBNtga4EJJzLHqlFAmULsErKIHN7zJOdrIyZabjGpiDUWEC0yd55LxmISuTvnILj4Z
         u8IHIpImuhoh3Qfch5XPF78qG1+O7C5Kp+GFD+3ga31Ky+HapgGQN/72Gd5KlMMZanmi
         YyhJ26e1iSjvrW0PReWGT3nd9TdRjy0sqkK1GqJqhV16SCq3qJ6ze1AgJuVkvYW35JFM
         2N0/fKaRYjwteHP9VrfZdyUcpTlDB9xYS8FOIuIVud6c3EeeLUa52pKAEMpAJQwoofHw
         kGJA==
X-Gm-Message-State: APjAAAX4T3mRkiDYi/A/rjEu/NPa/floTLqLC0JX2PWk4XIm+I+NK17i
        aleXFwyG+e8I4e9zPHrFmcplfhyg/0qevQEAiypNblSAbJhteFfPdRRtmHKVTtyOHduSzXSqLVh
        BpBg5NsUe2oh0
X-Received: by 2002:ac2:5295:: with SMTP id q21mr4257009lfm.93.1572542810758;
        Thu, 31 Oct 2019 10:26:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeWvPnvTGFquc7siuUR44AVowTB9iuVMOZyAF8EeV0Ihrvn6sBgQt6HD6XdvDGQDh18ylP4A==
X-Received: by 2002:ac2:5295:: with SMTP id q21mr4256988lfm.93.1572542810467;
        Thu, 31 Oct 2019 10:26:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h22sm1427249ljg.12.2019.10.31.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 10:26:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E79B21818B5; Thu, 31 Oct 2019 18:26:48 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Store map pin path and status in struct bpf_map
In-Reply-To: <CAEf4BzZ4pRLhwX+5Hh1jKsEhBAkrZbC14rBgAVgUt1gf3qJ+KQ@mail.gmail.com>
References: <157237796219.169521.2129132883251452764.stgit@toke.dk> <157237796448.169521.1399805620810530569.stgit@toke.dk> <CAEf4BzZ4pRLhwX+5Hh1jKsEhBAkrZbC14rBgAVgUt1gf3qJ+KQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 31 Oct 2019 18:26:48 +0100
Message-ID: <875zk4omg7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 29, 2019 at 12:39 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Support storing and setting a pin path in struct bpf_map, which can be used
>> for automatic pinning. Also store the pin status so we can avoid attempts
>> to re-pin a map that has already been pinned (or reused from a previous
>> pinning).
>>
>> The behaviour of bpf_object__{un,}pin_maps() is changed so that if it is
>> called with a NULL path argument (which was previously illegal), it will
>> (un)pin only those maps that have a pin_path set.
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>
> Looks good, thanks! Just some minor things to fix up below.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
>>  tools/lib/bpf/libbpf.c   |  164 +++++++++++++++++++++++++++++++++++-----------
>>  tools/lib/bpf/libbpf.h   |    8 ++
>>  tools/lib/bpf/libbpf.map |    3 +
>>  3 files changed, 134 insertions(+), 41 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index ce5ef3ddd263..fd11f6aeb32c 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -226,6 +226,8 @@ struct bpf_map {
>>         void *priv;
>>         bpf_map_clear_priv_t clear_priv;
>>         enum libbpf_map_type libbpf_type;
>> +       char *pin_path;
>> +       bool pinned;
>>  };
>>
>>  struct bpf_secdata {
>> @@ -4025,47 +4027,119 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
>>         char *cp, errmsg[STRERR_BUFSIZE];
>>         int err;
>>
>> -       err = check_path(path);
>> -       if (err)
>> -               return err;
>> -
>>         if (map == NULL) {
>>                 pr_warn("invalid map pointer\n");
>>                 return -EINVAL;
>>         }
>>
>> -       if (bpf_obj_pin(map->fd, path)) {
>> -               cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
>> -               pr_warn("failed to pin map: %s\n", cp);
>> -               return -errno;
>> +       if (map->pin_path) {
>> +               if (path && strcmp(path, map->pin_path)) {
>> +                       pr_warn("map '%s' already has pin path '%s' different from '%s'\n",
>> +                               bpf_map__name(map), map->pin_path, path);
>> +                       return -EINVAL;
>> +               } else if (map->pinned) {
>> +                       pr_debug("map '%s' already pinned at '%s'; not re-pinning\n",
>> +                                bpf_map__name(map), map->pin_path);
>> +                       return 0;
>> +               }
>
> `if (map->pinned)` check is the same in both branches, so I'd do it
> first, before this map->pin_path if/else.

But it's not. It's debug & return if pin_path is set, and an error
otherwise.

Will fix the rest of your nits :)

-Toke
