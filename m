Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEF2A5FDF
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKDIwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 03:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgKDIwG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 03:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604479924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEUt5EUH16YvaUhu9JLMer/1MWLivZjYY/q1IODAmqs=;
        b=BjJCyAtK6Pk4VFJY3kALAeNEr3HoRW5WpXvmecYpipVB21usXFtFBCdWu3YYDU1cnS8RgT
        fvNiPhR8sTi7rkVj4qHNVYw9xhloZ182D7hyk/tsoupgBKhfTR2PBMRjsMT6lzQha1Ta7T
        rRBXzx7mEpQc/9SnxUxPDobrBUHngWA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-PCqslXHaMxK_T4H6GXQJoA-1; Wed, 04 Nov 2020 03:52:03 -0500
X-MC-Unique: PCqslXHaMxK_T4H6GXQJoA-1
Received: by mail-pl1-f200.google.com with SMTP id z11so12632528pln.0
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 00:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xEUt5EUH16YvaUhu9JLMer/1MWLivZjYY/q1IODAmqs=;
        b=umgOvGPqrtDxTVFQ028fPbF+cKX8w3F7IiawAalCkPoygYhYBcp5rVZjZiul8irb2V
         9B6wf2O0VTtWTzijXADanbzfiuwT+zKnxgB81A+uoUy02DVajPB9IKt0LDVf0vSrMJpG
         u8I9gHlbj91VtXLpEssJRggfs5cEfHsH6jwhAskjK42urAYrh6ODsy3jVj95hwWyYZga
         wWOeXsf9T/d9qh6DxGeYy5ZVkJP1X3aku1JFTyEj0qZvqL9itjN+YnB22nydkZVmsply
         Rn7AtcRZ8fv9s4C+rrpKMolRCo6CDU9p2/mlVtkFHo7UqBkaN1fgzv4wHRlX2nKynNOL
         NEbw==
X-Gm-Message-State: AOAM532BZJkbOUr4KlyfPT7ecXqmu42QNVluYdMdse/ltNBLC9to84+w
        2SpL1KnLOba6aRWL/BWZWp6Rly488MkvaiCReLgNPifdaE0I0zfuL3WV/MjpsuAsfTyH8/qjVZ1
        1JUMMlcZJPxk=
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr2678193pjb.81.1604479922129;
        Wed, 04 Nov 2020 00:52:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCQhWYERz6hxQnPPSTbwhK08O8t2kDESGcVJbn64vjo7BnJ8Ci65snM49uwBfRwT/tIVeA9g==
X-Received: by 2002:a17:90b:1642:: with SMTP id il2mr2678176pjb.81.1604479921809;
        Wed, 04 Nov 2020 00:52:01 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nh24sm1511767pjb.44.2020.11.04.00.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 00:52:01 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:51:49 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv3 iproute2-next 1/5] configure: add check_libbpf() for
 later libbpf support
Message-ID: <20201104085149.GQ2408@dhcp-12-153.nay.redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <20201029151146.3810859-2-haliu@redhat.com>
 <78c5df29-bf06-0b60-d914-bdab3d65b198@gmail.com>
 <20201103055419.GI2408@dhcp-12-153.nay.redhat.com>
 <e3368c04-2887-3daf-8be8-8717960e9a18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3368c04-2887-3daf-8be8-8717960e9a18@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 03, 2020 at 10:32:37AM -0700, David Ahern wrote:
> configure scripts usually allow you to control options directly,
> overriding the autoprobe.

What do you think of the follow update? It's a little rough and only controls
libbpf.

$ git diff
diff --git a/configure b/configure
index 711bb69c..be35c024 100755
--- a/configure
+++ b/configure
@@ -442,6 +442,35 @@ endif
 EOF
 }

+usage()
+{
+       cat <<EOF
+Usage: $0 [OPTIONS]
+  -h | --help                  Show this usage info
+  --no-libbpf                  build the package without libbpf
+  --libbpf-dir=DIR             build the package with self defined libbpf dir
+EOF
+       exit $1
+}
+
+while true; do
+       case "$1" in
+               --libbpf-dir)
+                       LIBBPF_DIR="$2"
+                       shift 2 ;;
+               --no-libbpf)
+                       NO_LIBBPF_CHECK=1
+                       shift ;;
+               -h | --help)
+                       usage 0 ;;
+               "")
+                       break ;;
+               *)
+                       usage 1 ;;
+       esac
+done
+
+
 echo "# Generated config based on" $INCLUDE >$CONFIG
 quiet_config >> $CONFIG

@@ -476,8 +505,10 @@ check_setns
 echo -n "SELinux support: "
 check_selinux

-echo -n "libbpf support: "
-check_libbpf
+if [ -z $NO_LIBBPF_CHECK ]; then
+       echo -n "libbpf support: "
+       check_libbpf
+fi

 echo -n "ELF support: "
 check_elf


$ ./configure -h
Usage: ./configure [OPTIONS]
  -h | --help                   Show this usage info
  --no-libbpf                   build the package without libbpf
  --libbpf-dir=DIR              build the package with self defined libbpf dir

Thanks
Hangbin

