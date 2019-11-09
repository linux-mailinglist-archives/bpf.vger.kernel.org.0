Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9548FF617C
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 21:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfKIUhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 15:37:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726470AbfKIUhe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 15:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573331852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShjURwV1pMiGnWc15Y9RqDoj+KHWqv/A8WsqK9DmPCI=;
        b=V4goYI4D1RCo1EzhaItwnkua9odg736+qP79yWCPRCaesO1vEo1gUQqgXTV1d83HtumUN7
        HW4GNmOMAJLK56+Qlr53igWOED+ZLxANv7mUO/3tIdVBxWRO5wUupOywnIpuYRdZru47fp
        JJYUK7f9I9iezmTH/GuE01BQJk9QvJk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-QqY9e8hdPLG-lrjQN0bVSA-1; Sat, 09 Nov 2019 15:37:31 -0500
Received: by mail-lf1-f71.google.com with SMTP id o140so2019657lff.18
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 12:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nbp3QfN0TQNkDe9Q9+yAlcUGzwTWjk7ZLS5MnwIXPgY=;
        b=PRicQLqwcyjURw0LG/6zz20i2CXhTjz0xYJY0rn5YoeM7XdkM5ODydj07x1b8vib1C
         s8bPeUQ8epw9teFKJvh3I60O0XZifJ6ELfpKxjVEPzm3ZWIT5A+Levvkc2IXbLnQNj8j
         eUOhlbw1AW5qgMo81Tku+XQ3kuPPPUX/kywJqOdqamzcGsf8zuFBHIHnf0K+r7tavBoT
         sHqFExcTDE23vT7ulCmMPDpsSL8OaDjqmrlhC8mVWpI6mkwnlGC8rjSFNmUo8uTHmWsl
         GLEn9dKvopk4lf/nIViKy5hUYbeHt4aXa3KnKIe+Eit6ZvZpQCyxwcKMOiqvHr9oVM79
         IUMA==
X-Gm-Message-State: APjAAAVyJI3zmW1cRLCmtrUyYpO3ZcOHXLKOjjaw6Pfj8tY6TEfEVESL
        J4KZO4LspNZQlywJ6AtWyGVvxUMLU67fBeY2UmYyIpdk9z/WML8Kc6lxKftIJw/jRZnZ/aDUr0v
        SXixPc+v2+0Qe
X-Received: by 2002:a2e:9904:: with SMTP id v4mr1146520lji.211.1573331850140;
        Sat, 09 Nov 2019 12:37:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAnfzo4hKQPET5sJkwq2JRyKrDI/3MOUeac0pIKwMZuJDAl193Z7qRwm9MlJM6Zb4vcRv3+Q==
X-Received: by 2002:a2e:9904:: with SMTP id v4mr1146507lji.211.1573331849999;
        Sat, 09 Nov 2019 12:37:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id r9sm5406245ljm.7.2019.11.09.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 12:37:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 71B0D1800CC; Sat,  9 Nov 2019 21:37:28 +0100 (CET)
Subject: [PATCH bpf-next v4 2/6] selftests/bpf: Add tests for automatic map
 unpinning on load failure
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 21:37:28 +0100
Message-ID: <157333184838.88376.8243704248624814775.stgit@toke.dk>
In-Reply-To: <157333184619.88376.13377736576285554047.stgit@toke.dk>
References: <157333184619.88376.13377736576285554047.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: QqY9e8hdPLG-lrjQN0bVSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

This add tests for the different variations of automatic map unpinning on
load failure.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/pinning.c |   20 +++++++++++++++++-=
--
 tools/testing/selftests/bpf/progs/test_pinning.c |    2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testi=
ng/selftests/bpf/prog_tests/pinning.c
index 525388971e08..041952524c55 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -163,12 +163,15 @@ void test_pinning(void)
 =09=09goto out;
 =09}
=20
-=09/* swap pin paths of the two maps */
+=09/* set pin paths so that nopinmap2 will attempt to reuse the map at
+=09 * pinpath (which will fail), but not before pinmap has already been
+=09 * reused
+=09 */
 =09bpf_object__for_each_map(map, obj) {
 =09=09if (!strcmp(bpf_map__name(map), "nopinmap"))
+=09=09=09err =3D bpf_map__set_pin_path(map, nopinpath2);
+=09=09else if (!strcmp(bpf_map__name(map), "nopinmap2"))
 =09=09=09err =3D bpf_map__set_pin_path(map, pinpath);
-=09=09else if (!strcmp(bpf_map__name(map), "pinmap"))
-=09=09=09err =3D bpf_map__set_pin_path(map, NULL);
 =09=09else
 =09=09=09continue;
=20
@@ -181,6 +184,17 @@ void test_pinning(void)
 =09if (CHECK(err !=3D -EINVAL, "param mismatch load", "err %d errno %d\n",=
 err, errno))
 =09=09goto out;
=20
+=09/* nopinmap2 should have been pinned and cleaned up again */
+=09err =3D stat(nopinpath2, &statbuf);
+=09if (CHECK(!err || errno !=3D ENOENT, "stat nopinpath2",
+=09=09  "err %d errno %d\n", err, errno))
+=09=09goto out;
+
+=09/* pinmap should still be there */
+=09err =3D stat(pinpath, &statbuf);
+=09if (CHECK(err, "stat pinpath", "err %d errno %d\n", err, errno))
+=09=09goto out;
+
 =09bpf_object__close(obj);
=20
 =09/* test auto-pinning at custom path with open opt */
diff --git a/tools/testing/selftests/bpf/progs/test_pinning.c b/tools/testi=
ng/selftests/bpf/progs/test_pinning.c
index f69a4a50d056..f20e7e00373f 100644
--- a/tools/testing/selftests/bpf/progs/test_pinning.c
+++ b/tools/testing/selftests/bpf/progs/test_pinning.c
@@ -21,7 +21,7 @@ struct {
 } nopinmap SEC(".maps");
=20
 struct {
-=09__uint(type, BPF_MAP_TYPE_ARRAY);
+=09__uint(type, BPF_MAP_TYPE_HASH);
 =09__uint(max_entries, 1);
 =09__type(key, __u32);
 =09__type(value, __u64);

