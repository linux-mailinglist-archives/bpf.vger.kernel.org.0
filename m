Return-Path: <bpf+bounces-4385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2F74A8CA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150922815F9
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694C1849;
	Fri,  7 Jul 2023 02:11:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2A7F;
	Fri,  7 Jul 2023 02:11:06 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373AC10F5;
	Thu,  6 Jul 2023 19:11:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so20180231fa.2;
        Thu, 06 Jul 2023 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688695863; x=1691287863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHRrE4wUp09rtLxZdIrITRFEP9zcx+9QPwG/vfDjNdQ=;
        b=Z4v9W9xyOg7cOdonQC1+XwMEGFJR0+hcBJ2gGOVcprZ2A/5dJ6kf2KKeIXMYC5mfht
         9jLdV15yRh7b8PBYrhLgVxb5GedaPR3bf3NegA5qMFxThUKgw7h6eyCAphA01mepvSg3
         /1apodngwCGTPcqmMVqphbp2HcPdsLX/gp6/Cg92TQ0q8sQlXQNXlG2PjHRvAen3Y9KT
         5K6o/ngOjl+aueU2zBRV0CXWrH/fGjuaI3JqIOx96raAN+o7JTjASMtrAo0o/T3R8vtX
         J8hyz7cbKENuv+FqEUXow/Yb+ZPFA/cySJczFn3L1j4Zs9ygGF787LG2Qoc6F1s46Oof
         r9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688695863; x=1691287863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHRrE4wUp09rtLxZdIrITRFEP9zcx+9QPwG/vfDjNdQ=;
        b=V3GMdB434927SUOEDEk+kKrLKYAEEKSNjy+PbQ3s3AIlXuN1couq6jK6vRlR6Nc/QT
         rTLfVlhvi09IVAmw0AdF1wJO3FeIjfbrBHHOLwaVBuaT3iRxL2Mr98TR30t3SH70dwYr
         bLQWfFj7iD4h9/8rMK4cg3jfs8PhfGqHQ7BUX+R/Lu9AZxcCKMmAdZuwsnLPAY2Ilr6p
         81LVrkHP5Q+EyzvI2GNispdZhM2HHjqV2RNa4utntGT9TBU9CoZmkAL3fXe8EDYyItLT
         Jy3ikw/hflNoFJp/I6DKwYFnaPtbISC5K8E5T4bejA796Z40a4BheGTNfz0Xj71EsV6P
         RFng==
X-Gm-Message-State: ABy/qLbgrmaEcsNcuq+xAfd3Z7/gdMmPU2SU9Qw/ACHXwVvjXnLmUhFd
	skcQwJqoNz0gC+oFsTMXb0ADFHQH4kRRgSSGnn4=
X-Google-Smtp-Source: APBJJlGUjVks7u1wItYv0TEZseGB+1KEyxd0t6+1MvLUpyReEIVqVhnxfQVyxxQT+Qq5KY/XUVAugvY5vsw45V4m5kw=
X-Received: by 2002:a05:651c:120c:b0:2b6:a08d:e142 with SMTP id
 i12-20020a05651c120c00b002b6a08de142mr2636267lja.7.1688695863199; Thu, 06 Jul
 2023 19:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-13-alexei.starovoitov@gmail.com> <2c09b7d7-b91c-c561-3fd6-b8483aab01dc@huaweicloud.com>
In-Reply-To: <2c09b7d7-b91c-c561-3fd6-b8483aab01dc@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 19:10:51 -0700
Message-ID: <CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 12/14] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000f60bc05ffdc255e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000000f60bc05ffdc255e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 6, 2023 at 6:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
>
>
> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> > Unlike bpf_mem_[cache_]free() that links objects for immediate reuse in=
to
> > per-cpu free list the _rcu() flavor waits for RCU grace period and then=
 moves
> > objects into free_by_rcu_ttrace list where they are waiting for RCU
> > task trace grace period to be freed into slab.
> >
> > The life cycle of objects:
> > alloc: dequeue free_llist
> > free: enqeueu free_llist
> > free_rcu: enqueue free_by_rcu -> waiting_for_gp
> > free_llist above high watermark -> free_by_rcu_ttrace
> > after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> > free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Hou Tao <houtao1@huawei.com>

Thank you very much for code reviews and feedback.

btw I still believe that ABA is a non issue and prefer to keep the code as-=
is,
but for the sake of experiment I've converted it to spin_lock
(see attached patch which I think uglifies the code)
and performance across bench htab-mem and map_perf_test
seems to be about the same.
Which was a bit surprising to me.
Could you please benchmark it on your system?

--0000000000000f60bc05ffdc255e
Content-Type: application/octet-stream; 
	name="0001-bpf-Address-hypothetical-ABA-issue-with-llist_del_fi.patch"
Content-Disposition: attachment; 
	filename="0001-bpf-Address-hypothetical-ABA-issue-with-llist_del_fi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljrxvp4i0>
X-Attachment-Id: f_ljrxvp4i0

RnJvbSAwZDZjMDZkNjVkYTgxY2IwNzAyMzhhM2E4OTAxNWMxOTI3MDg1ZmZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBUaHUsIDYgSnVsIDIwMjMgMTk6MDU6MjQgLTA3MDAKU3ViamVjdDogW1BBVENIIGJwZi1u
ZXh0XSBicGY6IEFkZHJlc3MgaHlwb3RoZXRpY2FsIEFCQSBpc3N1ZSB3aXRoCiBsbGlzdF9kZWxf
Zmlyc3QKClNpZ25lZC1vZmYtYnk6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+
Ci0tLQoga2VybmVsL2JwZi9oYXNodGFiLmMgIHwgIDIgKy0KIGtlcm5lbC9icGYvbWVtYWxsb2Mu
YyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEva2VybmVsL2JwZi9oYXNodGFiLmMgYi9rZXJuZWwvYnBmL2hhc2h0YWIuYwppbmRleCA1NmQz
ZGE3ZDBiYzYuLmFlYmI5N2IxYzU3NSAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9oYXNodGFiLmMK
KysrIGIva2VybmVsL2JwZi9oYXNodGFiLmMKQEAgLTg3Niw3ICs4NzYsNyBAQCBzdGF0aWMgdm9p
ZCBodGFiX2VsZW1fZnJlZShzdHJ1Y3QgYnBmX2h0YWIgKmh0YWIsIHN0cnVjdCBodGFiX2VsZW0g
KmwpCiAJY2hlY2tfYW5kX2ZyZWVfZmllbGRzKGh0YWIsIGwpOwogCWlmIChodGFiLT5tYXAubWFw
X3R5cGUgPT0gQlBGX01BUF9UWVBFX1BFUkNQVV9IQVNIKQogCQlicGZfbWVtX2NhY2hlX2ZyZWUo
Jmh0YWItPnBjcHVfbWEsIGwtPnB0cl90b19wcHRyKTsKLQlicGZfbWVtX2NhY2hlX2ZyZWUoJmh0
YWItPm1hLCBsKTsKKwlicGZfbWVtX2NhY2hlX2ZyZWVfcmN1KCZodGFiLT5tYSwgbCk7CiB9CiAK
IHN0YXRpYyB2b2lkIGh0YWJfcHV0X2ZkX3ZhbHVlKHN0cnVjdCBicGZfaHRhYiAqaHRhYiwgc3Ry
dWN0IGh0YWJfZWxlbSAqbCkKZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvbWVtYWxsb2MuYyBiL2tl
cm5lbC9icGYvbWVtYWxsb2MuYwppbmRleCA1MWQ2Mzg5ZTUxNTIuLjZlZjMzMWU2MzllZSAxMDA2
NDQKLS0tIGEva2VybmVsL2JwZi9tZW1hbGxvYy5jCisrKyBiL2tlcm5lbC9icGYvbWVtYWxsb2Mu
YwpAQCAtMTE1LDYgKzExNSw3IEBAIHN0cnVjdCBicGZfbWVtX2NhY2hlIHsKIAlzdHJ1Y3QgbGxp
c3RfaGVhZCB3YWl0aW5nX2Zvcl9ncF90dHJhY2U7CiAJc3RydWN0IHJjdV9oZWFkIHJjdV90dHJh
Y2U7CiAJYXRvbWljX3QgY2FsbF9yY3VfdHRyYWNlX2luX3Byb2dyZXNzOworCXJhd19zcGlubG9j
a190IGxvY2s7CiB9OwogCiBzdHJ1Y3QgYnBmX21lbV9jYWNoZXMgewpAQCAtMjA0LDI5ICsyMDUs
MzQgQEAgc3RhdGljIHZvaWQgYWRkX29ial90b19mcmVlX2xpc3Qoc3RydWN0IGJwZl9tZW1fY2Fj
aGUgKmMsIHZvaWQgKm9iaikKIHN0YXRpYyB2b2lkIGFsbG9jX2J1bGsoc3RydWN0IGJwZl9tZW1f
Y2FjaGUgKmMsIGludCBjbnQsIGludCBub2RlKQogewogCXN0cnVjdCBtZW1fY2dyb3VwICptZW1j
ZyA9IE5VTEwsICpvbGRfbWVtY2c7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAl2b2lkICpvYmo7
CiAJaW50IGk7CiAKKwlyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmMtPmxvY2ssIGZsYWdzKTsKIAlm
b3IgKGkgPSAwOyBpIDwgY250OyBpKyspIHsKIAkJLyoKIAkJICogRm9yIGV2ZXJ5ICdjJyBsbGlz
dF9kZWxfZmlyc3QoJmMtPmZyZWVfYnlfcmN1X3R0cmFjZSk7IGlzCiAJCSAqIGRvbmUgb25seSBi
eSBvbmUgQ1BVID09IGN1cnJlbnQgQ1BVLiBPdGhlciBDUFVzIG1pZ2h0CiAJCSAqIGxsaXN0X2Fk
ZCgpIGFuZCBsbGlzdF9kZWxfYWxsKCkgaW4gcGFyYWxsZWwuCiAJCSAqLwotCQlvYmogPSBsbGlz
dF9kZWxfZmlyc3QoJmMtPmZyZWVfYnlfcmN1X3R0cmFjZSk7CisJCW9iaiA9IF9fbGxpc3RfZGVs
X2ZpcnN0KCZjLT5mcmVlX2J5X3JjdV90dHJhY2UpOwogCQlpZiAoIW9iaikKIAkJCWJyZWFrOwog
CQlhZGRfb2JqX3RvX2ZyZWVfbGlzdChjLCBvYmopOwogCX0KLQlpZiAoaSA+PSBjbnQpCisJaWYg
KGkgPj0gY250KSB7CisJCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZjLT5sb2NrLCBmbGFn
cyk7CiAJCXJldHVybjsKKwl9CiAKIAlmb3IgKDsgaSA8IGNudDsgaSsrKSB7Ci0JCW9iaiA9IGxs
aXN0X2RlbF9maXJzdCgmYy0+d2FpdGluZ19mb3JfZ3BfdHRyYWNlKTsKKwkJb2JqID0gX19sbGlz
dF9kZWxfZmlyc3QoJmMtPndhaXRpbmdfZm9yX2dwX3R0cmFjZSk7CiAJCWlmICghb2JqKQogCQkJ
YnJlYWs7CiAJCWFkZF9vYmpfdG9fZnJlZV9saXN0KGMsIG9iaik7CiAJfQorCXJhd19zcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZjLT5sb2NrLCBmbGFncyk7CiAJaWYgKGkgPj0gY250KQogCQlyZXR1
cm47CiAKQEAgLTI3Myw4ICsyNzksMTMgQEAgc3RhdGljIGludCBmcmVlX2FsbChzdHJ1Y3QgbGxp
c3Rfbm9kZSAqbGxub2RlLCBib29sIHBlcmNwdSkKIHN0YXRpYyB2b2lkIF9fZnJlZV9yY3Uoc3Ry
dWN0IHJjdV9oZWFkICpoZWFkKQogewogCXN0cnVjdCBicGZfbWVtX2NhY2hlICpjID0gY29udGFp
bmVyX29mKGhlYWQsIHN0cnVjdCBicGZfbWVtX2NhY2hlLCByY3VfdHRyYWNlKTsKKwlzdHJ1Y3Qg
bGxpc3Rfbm9kZSAqbGxub2RlOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLQlmcmVlX2FsbChs
bGlzdF9kZWxfYWxsKCZjLT53YWl0aW5nX2Zvcl9ncF90dHJhY2UpLCAhIWMtPnBlcmNwdV9zaXpl
KTsKKwlyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJmMtPmxvY2ssIGZsYWdzKTsKKwlsbG5vZGUgPSBf
X2xsaXN0X2RlbF9hbGwoJmMtPndhaXRpbmdfZm9yX2dwX3R0cmFjZSk7CisJcmF3X3NwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmMtPmxvY2ssIGZsYWdzKTsKKwlmcmVlX2FsbChsbG5vZGUsICEhYy0+
cGVyY3B1X3NpemUpOwogCWF0b21pY19zZXQoJmMtPmNhbGxfcmN1X3R0cmFjZV9pbl9wcm9ncmVz
cywgMCk7CiB9CiAKQEAgLTI5MiwyOCArMzAzLDM2IEBAIHN0YXRpYyB2b2lkIF9fZnJlZV9yY3Vf
dGFza3NfdHJhY2Uoc3RydWN0IHJjdV9oZWFkICpoZWFkKQogc3RhdGljIHZvaWQgZW5xdWVfdG9f
ZnJlZShzdHJ1Y3QgYnBmX21lbV9jYWNoZSAqYywgdm9pZCAqb2JqKQogewogCXN0cnVjdCBsbGlz
dF9ub2RlICpsbG5vZGUgPSBvYmo7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCS8qIGJwZl9t
ZW1fY2FjaGUgaXMgYSBwZXItY3B1IG9iamVjdC4gRnJlZWluZyBoYXBwZW5zIGluIGlycV93b3Jr
LgogCSAqIE5vdGhpbmcgcmFjZXMgdG8gYWRkIHRvIGZyZWVfYnlfcmN1X3R0cmFjZSBsaXN0Lgog
CSAqLwotCWxsaXN0X2FkZChsbG5vZGUsICZjLT5mcmVlX2J5X3JjdV90dHJhY2UpOworCXJhd19z
cGluX2xvY2tfaXJxc2F2ZSgmYy0+bG9jaywgZmxhZ3MpOworCV9fbGxpc3RfYWRkKGxsbm9kZSwg
JmMtPmZyZWVfYnlfcmN1X3R0cmFjZSk7CisJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmMt
PmxvY2ssIGZsYWdzKTsKIH0KIAogc3RhdGljIHZvaWQgZG9fY2FsbF9yY3VfdHRyYWNlKHN0cnVj
dCBicGZfbWVtX2NhY2hlICpjKQogewogCXN0cnVjdCBsbGlzdF9ub2RlICpsbG5vZGUsICp0Owor
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKIAlpZiAoYXRvbWljX3hjaGcoJmMtPmNhbGxfcmN1X3R0
cmFjZV9pbl9wcm9ncmVzcywgMSkpIHsKIAkJaWYgKHVubGlrZWx5KFJFQURfT05DRShjLT5kcmFp
bmluZykpKSB7Ci0JCQlsbG5vZGUgPSBsbGlzdF9kZWxfYWxsKCZjLT5mcmVlX2J5X3JjdV90dHJh
Y2UpOworCQkJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZjLT5sb2NrLCBmbGFncyk7CisJCQlsbG5v
ZGUgPSBfX2xsaXN0X2RlbF9hbGwoJmMtPmZyZWVfYnlfcmN1X3R0cmFjZSk7CisJCQlyYXdfc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmYy0+bG9jaywgZmxhZ3MpOwogCQkJZnJlZV9hbGwobGxub2Rl
LCAhIWMtPnBlcmNwdV9zaXplKTsKIAkJfQogCQlyZXR1cm47CiAJfQogCisJcmF3X3NwaW5fbG9j
a19pcnFzYXZlKCZjLT5sb2NrLCBmbGFncyk7CiAJV0FSTl9PTl9PTkNFKCFsbGlzdF9lbXB0eSgm
Yy0+d2FpdGluZ19mb3JfZ3BfdHRyYWNlKSk7Ci0JbGxpc3RfZm9yX2VhY2hfc2FmZShsbG5vZGUs
IHQsIGxsaXN0X2RlbF9hbGwoJmMtPmZyZWVfYnlfcmN1X3R0cmFjZSkpCi0JCWxsaXN0X2FkZChs
bG5vZGUsICZjLT53YWl0aW5nX2Zvcl9ncF90dHJhY2UpOworCWxsaXN0X2Zvcl9lYWNoX3NhZmUo
bGxub2RlLCB0LCBfX2xsaXN0X2RlbF9hbGwoJmMtPmZyZWVfYnlfcmN1X3R0cmFjZSkpCisJCV9f
bGxpc3RfYWRkKGxsbm9kZSwgJmMtPndhaXRpbmdfZm9yX2dwX3R0cmFjZSk7CisJcmF3X3NwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmMtPmxvY2ssIGZsYWdzKTsKIAogCWlmICh1bmxpa2VseShSRUFE
X09OQ0UoYy0+ZHJhaW5pbmcpKSkgewogCQlfX2ZyZWVfcmN1KCZjLT5yY3VfdHRyYWNlKTsKQEAg
LTM2MCwxMiArMzc5LDE1IEBAIHN0YXRpYyB2b2lkIF9fZnJlZV9ieV9yY3Uoc3RydWN0IHJjdV9o
ZWFkICpoZWFkKQogCXN0cnVjdCBicGZfbWVtX2NhY2hlICpjID0gY29udGFpbmVyX29mKGhlYWQs
IHN0cnVjdCBicGZfbWVtX2NhY2hlLCByY3UpOwogCXN0cnVjdCBicGZfbWVtX2NhY2hlICp0Z3Qg
PSBjLT50Z3Q7CiAJc3RydWN0IGxsaXN0X25vZGUgKmxsbm9kZTsKKwl1bnNpZ25lZCBsb25nIGZs
YWdzOwogCiAJbGxub2RlID0gbGxpc3RfZGVsX2FsbCgmYy0+d2FpdGluZ19mb3JfZ3ApOwogCWlm
ICghbGxub2RlKQogCQlnb3RvIG91dDsKIAotCWxsaXN0X2FkZF9iYXRjaChsbG5vZGUsIGMtPndh
aXRpbmdfZm9yX2dwX3RhaWwsICZ0Z3QtPmZyZWVfYnlfcmN1X3R0cmFjZSk7CisJcmF3X3NwaW5f
bG9ja19pcnFzYXZlKCZ0Z3QtPmxvY2ssIGZsYWdzKTsKKwlfX2xsaXN0X2FkZF9iYXRjaChsbG5v
ZGUsIGMtPndhaXRpbmdfZm9yX2dwX3RhaWwsICZ0Z3QtPmZyZWVfYnlfcmN1X3R0cmFjZSk7CisJ
cmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRndC0+bG9jaywgZmxhZ3MpOwogCiAJLyogT2Jq
ZWN0cyB3ZW50IHRocm91Z2ggcmVndWxhciBSQ1UgR1AuIFNlbmQgdGhlbSB0byBSQ1UgdGFza3Mg
dHJhY2UgKi8KIAlkb19jYWxsX3JjdV90dHJhY2UodGd0KTsKQEAgLTUxNyw2ICs1MzksNyBAQCBp
bnQgYnBmX21lbV9hbGxvY19pbml0KHN0cnVjdCBicGZfbWVtX2FsbG9jICptYSwgaW50IHNpemUs
IGJvb2wgcGVyY3B1KQogCQkJYy0+b2JqY2cgPSBvYmpjZzsKIAkJCWMtPnBlcmNwdV9zaXplID0g
cGVyY3B1X3NpemU7CiAJCQljLT50Z3QgPSBjOworCQkJcmF3X3NwaW5fbG9ja19pbml0KCZjLT5s
b2NrKTsKIAkJCXByZWZpbGxfbWVtX2NhY2hlKGMsIGNwdSk7CiAJCX0KIAkJbWEtPmNhY2hlID0g
cGM7CkBAIC01NDAsNiArNTYzLDcgQEAgaW50IGJwZl9tZW1fYWxsb2NfaW5pdChzdHJ1Y3QgYnBm
X21lbV9hbGxvYyAqbWEsIGludCBzaXplLCBib29sIHBlcmNwdSkKIAkJCWMtPnVuaXRfc2l6ZSA9
IHNpemVzW2ldOwogCQkJYy0+b2JqY2cgPSBvYmpjZzsKIAkJCWMtPnRndCA9IGM7CisJCQlyYXdf
c3Bpbl9sb2NrX2luaXQoJmMtPmxvY2spOwogCQkJcHJlZmlsbF9tZW1fY2FjaGUoYywgY3B1KTsK
IAkJfQogCX0KQEAgLTU1MCw2ICs1NzQsNyBAQCBpbnQgYnBmX21lbV9hbGxvY19pbml0KHN0cnVj
dCBicGZfbWVtX2FsbG9jICptYSwgaW50IHNpemUsIGJvb2wgcGVyY3B1KQogc3RhdGljIHZvaWQg
ZHJhaW5fbWVtX2NhY2hlKHN0cnVjdCBicGZfbWVtX2NhY2hlICpjKQogewogCWJvb2wgcGVyY3B1
ID0gISFjLT5wZXJjcHVfc2l6ZTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJLyogTm8gcHJv
Z3MgYXJlIHVzaW5nIHRoaXMgYnBmX21lbV9jYWNoZSwgYnV0IGh0YWJfbWFwX2ZyZWUoKSBjYWxs
ZWQKIAkgKiBicGZfbWVtX2NhY2hlX2ZyZWUoKSBmb3IgYWxsIHJlbWFpbmluZyBlbGVtZW50cyBh
bmQgdGhleSBjYW4gYmUgaW4KQEAgLTU1OCw4ICs1ODMsMTAgQEAgc3RhdGljIHZvaWQgZHJhaW5f
bWVtX2NhY2hlKHN0cnVjdCBicGZfbWVtX2NhY2hlICpjKQogCSAqIEV4Y2VwdCBmb3Igd2FpdGlu
Z19mb3JfZ3BfdHRyYWNlIGxpc3QsIHRoZXJlIGFyZSBubyBjb25jdXJyZW50IG9wZXJhdGlvbnMK
IAkgKiBvbiB0aGVzZSBsaXN0cywgc28gaXQgaXMgc2FmZSB0byB1c2UgX19sbGlzdF9kZWxfYWxs
KCkuCiAJICovCi0JZnJlZV9hbGwobGxpc3RfZGVsX2FsbCgmYy0+ZnJlZV9ieV9yY3VfdHRyYWNl
KSwgcGVyY3B1KTsKLQlmcmVlX2FsbChsbGlzdF9kZWxfYWxsKCZjLT53YWl0aW5nX2Zvcl9ncF90
dHJhY2UpLCBwZXJjcHUpOworCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmYy0+bG9jaywgZmxhZ3Mp
OworCWZyZWVfYWxsKF9fbGxpc3RfZGVsX2FsbCgmYy0+ZnJlZV9ieV9yY3VfdHRyYWNlKSwgcGVy
Y3B1KTsKKwlmcmVlX2FsbChfX2xsaXN0X2RlbF9hbGwoJmMtPndhaXRpbmdfZm9yX2dwX3R0cmFj
ZSksIHBlcmNwdSk7CisJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmMtPmxvY2ssIGZsYWdz
KTsKIAlmcmVlX2FsbChfX2xsaXN0X2RlbF9hbGwoJmMtPmZyZWVfbGxpc3QpLCBwZXJjcHUpOwog
CWZyZWVfYWxsKF9fbGxpc3RfZGVsX2FsbCgmYy0+ZnJlZV9sbGlzdF9leHRyYSksIHBlcmNwdSk7
CiAJZnJlZV9hbGwoX19sbGlzdF9kZWxfYWxsKCZjLT5mcmVlX2J5X3JjdSksIHBlcmNwdSk7Ci0t
IAoyLjM0LjEKCg==
--0000000000000f60bc05ffdc255e--

