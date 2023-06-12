Return-Path: <bpf+bounces-2403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DD72C94E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2341C20B76
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0271C757;
	Mon, 12 Jun 2023 15:05:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A919BB6
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:05:52 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2098
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 08:05:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f624daccd1so4990898e87.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582344; x=1689174344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0MOKu5vyY7HZZ/9P4hJaJjwqY1appgnZ/cW+IBvbNw=;
        b=g3GfxTYACNpD2cXnL76pdUzhgDzsxXzUrTwSxC8cJKPaQkhrZlsoguWTVMJk4ACiZl
         YARhwoHsYKEnOZHRJ1/Ypo6MWmGQvLN4iC3UZea9bW/yut7JpjXiv6EFl9X2u3LmDGY6
         8neZvf9ZLt4whzXVhKk/MT6I/cHQo49SnymJdwum+HZtIlLD7UgCmlKwiSk/3Bl8ZiCW
         0jdcwz6xhu/5MVPdyYSiOX+onf7MmLDsDe0GqO5wBSx1gn313aH01T0IU92Gy17V9NYh
         4jy7oXQpCgoug69X8UUJVw9ra5+Gd8jHcU1TGP0/HX04KcPg++Bad1Zj5xkOqhFf4f0i
         YVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582344; x=1689174344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0MOKu5vyY7HZZ/9P4hJaJjwqY1appgnZ/cW+IBvbNw=;
        b=UrpV6sbCFDgSe2IShHbj0qMQOqJTISmP6rr5ir8oucGjqP/JXf3CRn+HYY0Isep1Fc
         TVklQhkvMxVw58JbjIruuYuHKkgx1po22kbAGKJaR7cZGsEGDeSoTy4MYsTM7/4BHUS2
         9hRwLDYBQtyNzBZzjYWj4yE0AXyFx+n9ptl1zFqlaD3F3cxYKBa36x8/t5NUYYfl1V1+
         MJ+vhAnKRlveNCfuZ/w6/QX1P/e6WCqQ+S9g8oXv0CSmJWBNmvA1Fc74fjtQs6k/viZS
         87IgnqQUDyn0oUdviS+D+kAwH0LrulAuPUHiDLpYs6M6rw4KTUX+2wyQ9s9cL5jIS055
         u7cQ==
X-Gm-Message-State: AC+VfDxRK8H/v8RvAgngs+PZ4luuBTJzF/HkUPyAuWZQTDBdbeE8Vx53
	7L1saEDNRKFkZvozFtmGiFs=
X-Google-Smtp-Source: ACHHUZ74DhWAZrdyzMsQhIWEGUhYAS4w6SJI88OiaaFVkk+lhFobme/LLIDw5K75XmII7e3b81JeMQ==
X-Received: by 2002:a19:3849:0:b0:4f6:a8e:de30 with SMTP id d9-20020a193849000000b004f60a8ede30mr3429662lfj.65.1686582344178;
        Mon, 12 Jun 2023 08:05:44 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w12-20020ac254ac000000b004db51387ad6sm1482714lfk.129.2023.06.12.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:05:43 -0700 (PDT)
Message-ID: <b1936c02fbda2ddc0b266d28b5de5c4aacbba191.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: fix invalid pointer check in
 get_xlated_program()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com,
  dan.carpenter@linaro.org
Date: Mon, 12 Jun 2023 18:05:42 +0300
In-Reply-To: <4f9f4242-6943-5305-20d5-0270aaf506ed@iogearbox.net>
References: <20230609221637.2631800-1-eddyz87@gmail.com>
	 <4f9f4242-6943-5305-20d5-0270aaf506ed@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-12 at 17:00 +0200, Daniel Borkmann wrote:
> On 6/10/23 12:16 AM, Eduard Zingerman wrote:
> > Dan Carpenter reported invalid check for calloc() result in
> > test_verifier.c:get_xlated_program():
> >=20
> >    ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_progra=
m()
> >    warn: variable dereferenced before check 'buf' (see line 1364)
> >=20
> >    ./tools/testing/selftests/bpf/test_verifier.c
> >      1363		*cnt =3D xlated_prog_len / buf_element_size;
> >      1364		*buf =3D calloc(*cnt, buf_element_size);
> >      1365		if (!buf) {
> >=20
> >    This should be if (!*buf) {
> >=20
> >      1366			perror("can't allocate xlated program buffer");
> >      1367			return -ENOMEM;
> >=20
> > This commit refactors the get_xlated_program() to avoid using double
> > pointer type.
>=20
> Isn't the small reported fix above sufficient? (Either is fine with me th=
ough.)

I think it is less prone to mechanical mistakes without double pointers
(in case if this function would be modified sometimes in the future).
But I can rollback to a small fix if you insist.

>=20
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/bpf/ZH7u0hEGVB4MjGZq@moroto/
> > Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in t=
est_verifier tests")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/test_verifier.c | 26 ++++++++++++--------=
-
> >   1 file changed, 15 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testin=
g/selftests/bpf/test_verifier.c
> > index 71704a38cac3..c6bc9e26d333 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -1341,45 +1341,48 @@ static bool cmp_str_seq(const char *log, const =
char *exp)
> >   	return true;
> >   }
> >  =20
> > -static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int =
*cnt)
> > +static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
> >   {
> >   	struct bpf_prog_info info =3D {};
> >   	__u32 info_len =3D sizeof(info);
> > +	__u32 buf_element_size;
> >   	__u32 xlated_prog_len;
> > -	__u32 buf_element_size =3D sizeof(struct bpf_insn);
> > +	struct bpf_insn *buf;
> > +
> > +	buf_element_size =3D sizeof(struct bpf_insn);
>=20
> Just small nit: the `__u32 buf_element_size =3D sizeof(struct bpf_insn);`=
 could have
> stayed as is.

Moved it to have "inverse Christmas tree" for declarations,
can send V2 undoing this.

>=20
> >   	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
> >   		perror("bpf_prog_get_info_by_fd failed");
> > -		return -1;
> > +		return NULL;
> >   	}
> >  =20
> >   	xlated_prog_len =3D info.xlated_prog_len;
> >   	if (xlated_prog_len % buf_element_size) {
> >   		printf("Program length %d is not multiple of %d\n",
> >   		       xlated_prog_len, buf_element_size);
> > -		return -1;
> > +		return NULL;
> >   	}
> >  =20
> >   	*cnt =3D xlated_prog_len / buf_element_size;
> > -	*buf =3D calloc(*cnt, buf_element_size);
> > +	buf =3D calloc(*cnt, buf_element_size);
> >   	if (!buf) {
> >   		perror("can't allocate xlated program buffer");
> > -		return -ENOMEM;
> > +		return NULL;
> >   	}
> >  =20
> >   	bzero(&info, sizeof(info));
> >   	info.xlated_prog_len =3D xlated_prog_len;
> > -	info.xlated_prog_insns =3D (__u64)(unsigned long)*buf;
> > +	info.xlated_prog_insns =3D (__u64)(unsigned long)buf;
> >   	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
> >   		perror("second bpf_prog_get_info_by_fd failed");
> >   		goto out_free_buf;
> >   	}
> >  =20
> > -	return 0;
> > +	return buf;
> >  =20
> >   out_free_buf:
> > -	free(*buf);
> > -	return -1;
> > +	free(buf);
> > +	return NULL;
> >   }
> >  =20
> >   static bool is_null_insn(struct bpf_insn *insn)
> > @@ -1512,7 +1515,8 @@ static bool check_xlated_program(struct bpf_test =
*test, int fd_prog)
> >   	if (!check_expected && !check_unexpected)
> >   		goto out;
> >  =20
> > -	if (get_xlated_program(fd_prog, &buf, &cnt)) {
> > +	buf =3D get_xlated_program(fd_prog, &cnt);
> > +	if (!buf) {
> >   		printf("FAIL: can't get xlated program\n");
> >   		result =3D false;
> >   		goto out;
> >=20
>=20


