Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26EF4A9BDB
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359654AbiBDPUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 10:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359644AbiBDPUU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643988019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+q46W6c4toAQsTdMEsRGsiR5ZgOxsHkl9SQEX7EvK04=;
        b=aouhAKNJi6NYo/hfbwKv6GqbfYWGYUcGlCJm0TBxpYW7WCqTapcQXhiGvOVOMZzCVU4Rwy
        jGxsT6iIF1e83rgBIfe9JOBlFu6XK5TduTEQMYuZHSzkejiilrrIUJBUxoUcogFOuruKeb
        ySgVx8DIYwrJDjpj/o2M4fjBRu8evk0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-0I-rn9tLNsmme4msvenZfQ-1; Fri, 04 Feb 2022 10:20:18 -0500
X-MC-Unique: 0I-rn9tLNsmme4msvenZfQ-1
Received: by mail-ed1-f69.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso3402932edj.9
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 07:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+q46W6c4toAQsTdMEsRGsiR5ZgOxsHkl9SQEX7EvK04=;
        b=SOF1gDQMiqrbQCDyuyCRnTpWGia03hq4TNM2EfIds5UxATolMt57pyKLHgDU5SN6+a
         wQxSE4TlkYcK3xWuC72FNbW2JTelg54/b3Tc+cNP7Mwj7Z24Dm0GTIqlG6ueYNblVp5t
         VQmvr5D6aYl/nXU9Cv529nX3MIbPAM/K3diKv8bjvFS/jKfpf6PmK6udGZyEMIfmKxJx
         t9eTnW8MLHP/DEJ9g+qHxR0g/xKt0VMrHTa/5DJ9tvBGzIG6z6JUcX+wKurTfyD6D+BJ
         LfSMlvWojmM+4XRbfYvMMywAD1HLA/+BlmvPRhiKHY2XQiQoDCcZWmPmWaDiWp0L1iNj
         1zJg==
X-Gm-Message-State: AOAM5316D/ra8Y/0zH4doJqOGGka/flijC7UCQX1sJi6UWlHC2PYrGPe
        f/Ia8e7PaA2y3+vNga51Jku1SD9qPQaVDq6/3k5e/UxmQWus0qbuhL8KpnKQ46K19doCR2NF53N
        UgaXU3N3Ii5KT
X-Received: by 2002:a17:906:794b:: with SMTP id l11mr3031429ejo.760.1643988017351;
        Fri, 04 Feb 2022 07:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSYyiKmfl2Gd0G8ZZlWKALFgw+5rgN6Bz7b8FzRYyJNdebkWK3OcH6557glemQNFvsMQVi2w==
X-Received: by 2002:a17:906:794b:: with SMTP id l11mr3031413ejo.760.1643988017093;
        Fri, 04 Feb 2022 07:20:17 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p12sm748709ejd.180.2022.02.04.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:20:16 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:20:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [RFC] failing selftests/bpf/test_offload.py
Message-ID: <Yf1ELsA5yhhBrJnf@krava>
References: <20220130225101.47514-1-jolsa@kernel.org>
 <87k0egt5b8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0egt5b8.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:15:07PM +0100, Toke Høiland-Jørgensen wrote:
> Jiri Olsa <jolsa@redhat.com> writes:
> 
> > hi,
> > I have failing test_offload.py with following output:
> >
> >   # ./test_offload.py
> >   ...
> >   Test bpftool bound info reporting (own ns)...
> >   FAIL: 3 BPF maps loaded, expected 2
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1177, in <module>
> >       check_dev_info(False, "")
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 645, in check_dev_info
> >       maps = bpftool_map_list(expected=2, ns=ns)
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 190, in bpftool_map_list
> >       fail(True, "%d BPF maps loaded, expected %d" %
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 86, in fail
> >       tb = "".join(traceback.extract_stack().format())
> >
> > it fails to detect maps from bpftool's feature detection,
> > that did not make it yet through deferred removal
> >
> > with the fix below I have this subtest passed, but it fails
> > further on:
> >
> >   # ./test_offload.py
> >   ...
> >   Test bpftool bound info reporting (own ns)...
> >   Test bpftool bound info reporting (other ns)...
> >   Test bpftool bound info reporting (remote ns)...
> >   Test bpftool bound info reporting (back to own ns)...
> >   Test bpftool bound info reporting (removed dev)...
> >   Test map update (no flags)...
> >   Test map update (exists)...
> >   Test map update (noexist)...
> >   Test map dump...
> >   Test map dump...
> >   Traceback (most recent call last):
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1251, in <module>
> >       _, entries = bpftool("map dump id %d" % (m["id"]))
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 169, in bpftool
> >       return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 155, in tool
> >       ret, stdout = cmd(ns + name + " " + params + args,
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 109, in cmd
> >       return cmd_result(proc, include_stderr=include_stderr, fail=fail)
> >     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 131, in cmd_result
> >       raise Exception("Command failed: %s\n%s" % (proc.args, stderr))
> >   Exception: Command failed: bpftool -p map dump id 4325
> >
> > the test seems to expect maps having BTF loaded, which for some reason
> > did not happen, so the test fails with bpftool pretty dump fail
> >
> > the test loads the object with 'ip link ...', which I never touched,
> > so I wanted ask first before I dive in, perhaps I miss some setup
> >
> > thoughts? ;-)
> 
> It looks like the test_offload.py has been using 'bpftool -p' since its
> inception (in commit: 417ec26477a5 ("selftests/bpf: add offload test
> based on netdevsim") introduced in December 2017), so this sounds like a
> regression in bpftool?
> 
> -Toke
> 

right, looks like this commit:
  e5043894b21f ("bpftool: Use libbpf_get_error() to check error")

forced btf for pretty map dump.. change below fixes the test for me,
I'll send full patchset for this later

thanks,
jirka


---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c66a3c979b7a..2ccf85042e75 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -862,6 +862,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	prev_key = NULL;
 
 	if (wtr) {
+		errno = 0;
 		btf = get_map_kv_btf(info);
 		err = libbpf_get_error(btf);
 		if (err) {
-- 
2.34.1

