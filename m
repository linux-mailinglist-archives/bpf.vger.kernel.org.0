Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E61E8F77
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfJ2So5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 29 Oct 2019 14:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ2So5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 14:44:57 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45DE881F07
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 18:44:56 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id p4so796074lfo.10
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 11:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6F1y4W/dkrcC5DlFvTaWlo8QE2stycmB00Su8cyPwKg=;
        b=Zm0gQWvBcjBS+dUhSLJVXfPNHE5c36bYbf/aZg592X8wn6q4pDq0fSiqzECDTpdlN/
         KSa+oGN7YvJ+JiGdp+RCglQIKYK27Vb+iPqL8pSJzNKnKTLHHmzSyQnPGlRNhLGYze3T
         AvZdrnHIU0tEFLH7U4oX+1iOR5XIjxBuMqexDATBssiORwRGa9N7hys/QXB1xxgx93fQ
         iQlElosaD1xwZfASeLVD2q1tPSJ4NENlCqcgg39vVXGTHML6kWyyLmo+IoLqB0e+wtqb
         BwEszgCNl79E3nviwpYuyK4fDjNv499N1aCTltrqF6oZOO764z4ENS9OsD8A9bAUVc3h
         MAmg==
X-Gm-Message-State: APjAAAV+ZMd9sglpZ5L9yn1osqdo/uGoUzVFE3aCCcEKR6ksNSUjkiBR
        yUt+hsFgehQDcdXBnPX3Y+zT0yP0OtNrNOzgGdQdQ6w64tQhzDxa/PKooIUTHyJZQKMd0Z5+DcK
        RHzGr0b3zxqYT
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr3797718lja.48.1572374694637;
        Tue, 29 Oct 2019 11:44:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzITFWTPEJlH9S0I3K58bJdBtTT18vs0JUPA1SxDuHkiZuxMEXzCTpRX+/1YsnYwfMVTxN+xQ==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr3797693lja.48.1572374694173;
        Tue, 29 Oct 2019 11:44:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o11sm6363207lfl.48.2019.10.29.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:44:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC3001818B6; Tue, 29 Oct 2019 19:44:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Add auto-pinning of maps when loading BPF objects
In-Reply-To: <CAEf4BzZe6h=0KN+uWdKcGU5VoRDDsvjNzyqh0=aT1u+EvT1x_g@mail.gmail.com>
References: <157220959547.48922.6623938299823744715.stgit@toke.dk> <157220959873.48922.4763375792594816553.stgit@toke.dk> <CAEf4BzYoEPKNFnzOEAhhE2w=U11cYfTN4o_23kjzY4ByEt5y-g@mail.gmail.com> <877e4nsxth.fsf@toke.dk> <CAEf4BzZe6h=0KN+uWdKcGU5VoRDDsvjNzyqh0=aT1u+EvT1x_g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Oct 2019 19:44:52 +0100
Message-ID: <878sp3qtln.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 29, 2019 at 2:30 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Sun, Oct 27, 2019 at 1:53 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> >>
>> >> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> >>
>> >> This adds support to libbpf for setting map pinning information as part of
>> >> the BTF map declaration, to get automatic map pinning (and reuse) on load.
>> >> The pinning type currently only supports a single PIN_BY_NAME mode, where
>> >> each map will be pinned by its name in a path that can be overridden, but
>> >> defaults to /sys/fs/bpf.
>> >>
>> >> Since auto-pinning only does something if any maps actually have a
>> >> 'pinning' BTF attribute set, we default the new option to enabled, on the
>> >> assumption that seamless pinning is what most callers want.
>> >>
>> >> When a map has a pin_path set at load time, libbpf will compare the map
>> >> pinned at that location (if any), and if the attributes match, will re-use
>> >> that map instead of creating a new one. If no existing map is found, the
>> >> newly created map will instead be pinned at the location.
>> >>
>> >> Programs wanting to customise the pinning can override the pinning paths
>> >> using bpf_map__set_pin_path() before calling bpf_object__load() (including
>> >> setting it to NULL to disable pinning of a particular map).
>> >>
>> >> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> >> ---
>> >>  tools/lib/bpf/bpf_helpers.h |    6 ++
>> >>  tools/lib/bpf/libbpf.c      |  142 ++++++++++++++++++++++++++++++++++++++++++-
>> >>  tools/lib/bpf/libbpf.h      |   11 +++
>> >>  3 files changed, 154 insertions(+), 5 deletions(-)
>> >>
>> >
>> > [...]
>> >
>> >>
>> >> -static int bpf_object__init_maps(struct bpf_object *obj, bool relaxed_maps)
>> >> +static int bpf_object__build_map_pin_paths(struct bpf_object *obj,
>> >> +                                          const char *path)
>> >> +{
>> >> +       struct bpf_map *map;
>> >> +
>> >> +       if (!path)
>> >> +               path = "/sys/fs/bpf";
>> >> +
>> >> +       bpf_object__for_each_map(map, obj) {
>> >> +               char buf[PATH_MAX];
>> >> +               int err, len;
>> >> +
>> >> +               if (map->pinning != LIBBPF_PIN_BY_NAME)
>> >> +                       continue;
>> >
>> > still think it's better be done from map definition parsing code
>> > instead of a separate path, which will ignore most of maps anyways (of
>> > course by extracting this whole buffer creation logic into a
>> > function).
>>
>> Hmm, okay, can do that. I think we should still store the actual value
>> of the 'pinning' attribute, though; and even have a getter for it. The
>> app may want to do something with that information instead of having to
>> infer it from map->pin_path. Certainly when we add other values of the
>> pinning attribute, but we may as well add the API to get the value
>> now...
>
> Let's now expose more stuff than what we need to expose. If we really
> will have a need for that, it's really easy to add. Right now you
> won't even need to store pinning attribute in bpf_map, because you'll
> be just setting proper pin_path in init_user_maps(), as suggested
> above.

While I do think it's a bit weird that there's an attribute you can set
but can't get at, I will grudgingly admit that it's not strictly needed
right now... So OK, I'll leave it out :)

>> >> +
>> >> +               len = snprintf(buf, PATH_MAX, "%s/%s", path, bpf_map__name(map));
>> >> +               if (len < 0)
>> >> +                       return -EINVAL;
>> >> +               else if (len >= PATH_MAX)
>> >
>> > [...]
>> >
>> >>         return 0;
>> >>  }
>> >>
>> >> +static bool map_is_reuse_compat(const struct bpf_map *map,
>> >> +                               int map_fd)
>> >
>> > nit: this should fit on single line?
>> >
>> >> +{
>> >> +       struct bpf_map_info map_info = {};
>> >> +       char msg[STRERR_BUFSIZE];
>> >> +       __u32 map_info_len;
>> >> +
>> >> +       map_info_len = sizeof(map_info);
>> >> +
>> >> +       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
>> >> +               pr_warn("failed to get map info for map FD %d: %s\n",
>> >> +                       map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
>> >> +               return false;
>> >> +       }
>> >> +
>> >> +       return (map_info.type == map->def.type &&
>> >> +               map_info.key_size == map->def.key_size &&
>> >> +               map_info.value_size == map->def.value_size &&
>> >> +               map_info.max_entries == map->def.max_entries &&
>> >> +               map_info.map_flags == map->def.map_flags &&
>> >> +               map_info.btf_key_type_id == map->btf_key_type_id &&
>> >> +               map_info.btf_value_type_id == map->btf_value_type_id);
>> >
>> > If map was pinned by older version of the same app, key and value type
>> > id are probably gonna be different, even if the type definition itself
>> > it correct. We probably shouldn't check that?
>>
>> Oh, I thought the type IDs would stay relatively stable. If not then I
>> agree that we shouldn't be checking them here. Will fix.
>
> type IDs are just an ordered index of a type, as generated by Clang.
> No stability guarantees. Just adding extra typedef somewhere in
> unrelated type might shift all the type IDs around.

Ah, so it's just numbering types within the same translation unit? I
thought it was somehow globally (or system-wide) unique (though not sure
how I imagined that would be achieved, TBH).

>> >> +}
>> >> +
>> >> +static int
>> >> +bpf_object__reuse_map(struct bpf_map *map)
>> >> +{
>> >> +       char *cp, errmsg[STRERR_BUFSIZE];
>> >> +       int err, pin_fd;
>> >> +
>> >> +       pin_fd = bpf_obj_get(map->pin_path);
>> >> +       if (pin_fd < 0) {
>> >> +               if (errno == ENOENT) {
>> >> +                       pr_debug("found no pinned map to reuse at '%s'\n",
>> >> +                                map->pin_path);
>> >> +                       return 0;
>> >> +               }
>> >> +
>> >> +               cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
>> >> +               pr_warn("couldn't retrieve pinned map '%s': %s\n",
>> >> +                       map->pin_path, cp);
>> >> +               return -errno;
>> >
>> > store errno locally
>>
>> *shrugs* okay, if you insist...
>
> I guess I do insist on correct handling of errno, instead of
> potentially returning garbage value from some unrelated syscall from
> inside of pr_warn's user-provided callback.
>
> Even libbpf_strerror_r can garble errno (e.g., through its strerror_r
> call), so make sure you store it before passing into
> libbpf_strerror_r().

Ohh, right, didn't think about those having side effects; then your
worry makes more sense. I thought you were just being pedantic, which is
why I was being grumpy (did change it, though) :)

>>
>> >> +       }
>> >> +
>> >> +       if (!map_is_reuse_compat(map, pin_fd)) {
>> >> +               pr_warn("couldn't reuse pinned map at '%s': "
>> >> +                       "parameter mismatch\n", map->pin_path);
>> >> +               close(pin_fd);
>> >> +               return -EINVAL;
>> >> +       }
>> >> +
>> >> +       err = bpf_map__reuse_fd(map, pin_fd);
>> >> +       if (err) {
>> >> +               close(pin_fd);
>> >> +               return err;
>> >> +       }
>> >> +       map->pinned = true;
>> >> +       pr_debug("reused pinned map at '%s'\n", map->pin_path);
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +
>> >
>> > [...]
>> >
>> >> +enum libbpf_pin_type {
>> >> +       LIBBPF_PIN_NONE,
>> >> +       /* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
>> >> +       LIBBPF_PIN_BY_NAME,
>> >> +};
>> >> +
>> >>  LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *path);
>> >
>> > pin_maps should take into account opts->auto_pin_path, shouldn't it?
>> >
>> > Which is why I also think that auto_pin_path is bad name, because it's
>> > not only for auto-pinning, it's a pinning root path, so something like
>> > pin_root_path or just pin_root is better and less misleading name.
>>
>> I view auto_pin_path as something that is used specifically for the
>> automatic pinning based on the 'pinning' attribute. Any other use of
>> pinning is for custom use and the user can pass a custom pin path to
>> those functions.
>
> What's the benefit of restricting it to just this use case? If app
> wants to use something other than /sys/fs/bpf as a default root path,
> why would that be restricted only to auto-pinned maps? It seems to me
> that having set this on bpf_object__open() and then calling
> bpf_object__pin_maps(NULL) should just take this overridden root path
> into account. Isn't that a logical behavior?

No, I think the logical behaviour is for pin_maps(NULL) to just pin all
maps at map->pin_path if set (and same for unpin). Already changed it to
this behaviour, actually.

-Toke
