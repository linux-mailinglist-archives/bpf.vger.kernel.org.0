Return-Path: <bpf+bounces-6035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C17764460
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 05:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000461C21471
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA3185D;
	Thu, 27 Jul 2023 03:33:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C621BEE4
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 03:33:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634DE75;
	Wed, 26 Jul 2023 20:33:06 -0700 (PDT)
X-UUID: 3cca24fa88994d4ba840e9aac1bc8355-20230727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:f242e993-158b-4ea5-85f9-ef4642d75f6c,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.1.28,REQID:f242e993-158b-4ea5-85f9-ef4642d75f6c,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:176cd25,CLOUDID:517194a0-0933-4333-8d4f-6c3c53ebd55b,B
	ulkID:230727052327ADIGKCI6,BulkQuantity:4,Recheck:0,SF:19|44|24|17|102,TC:
	nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3cca24fa88994d4ba840e9aac1bc8355-20230727
X-User: guodongtai@kylinos.cn
Received: from ky [(39.156.73.12)] by mailgw
	(envelope-from <guodongtai@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 455361928; Thu, 27 Jul 2023 11:32:51 +0800
Date: Thu, 27 Jul 2023 11:32:51 +0800
From: <guodongtai@kylinos.cn>
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, nathan@kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Update sockex2: get the expected output
 results
Message-ID: <20230727113251.15f538ab@ky>
In-Reply-To: <ZMGOqYG8oCAQmMtq@fjasle.eu>
References: <20230726070955.178288-1-guodongtai@kylinos.cn>
	<ZMGOqYG8oCAQmMtq@fjasle.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 23:22:49 +0200
Nicolas Schier <nicolas@fjasle.eu> wrote:

> On Wed, Jul 26, 2023 at 03:09:55PM +0800 George Guo wrote:
> > Running "ping -4 -c5 localhost" only shows 4 times prints not 5:
> >=20
> > $ sudo ./samples/bpf/sockex2
> > ip 127.0.0.1 bytes 392 packets 4
> > ip 127.0.0.1 bytes 784 packets 8
> > ip 127.0.0.1 bytes 1176 packets 12
> > ip 127.0.0.1 bytes 1568 packets 16
> >=20
> > debug it with num prints:
> > $ sudo ./samples/bpf/sockex2
> > num =3D 1: ip 127.0.0.1 bytes 392 packets 4
> > num =3D 2: ip 127.0.0.1 bytes 784 packets 8
> > num =3D 3: ip 127.0.0.1 bytes 1176 packets 12
> > num =3D 4: ip 127.0.0.1 bytes 1568 packets 16
> >=20
> > The reason is that we check it faster, just put sleep(1) before
> > check while(bpf_map_get_next_key(map_fd, &key, &next_key) =3D=3D 0).
> > Now we get the expected results:
> >=20
> > $ sudo ./samples/bpf/sockex2
> > num =3D 0: ip 127.0.0.1 bytes 392 packets 4
> > num =3D 1: ip 127.0.0.1 bytes 784 packets 8
> > num =3D 2: ip 127.0.0.1 bytes 1176 packets 12
> > num =3D 3: ip 127.0.0.1 bytes 1568 packets 16
> > num =3D 4: ip 127.0.0.1 bytes 1960 packets 20
> >=20
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > --- =20
>=20
> Thanks, sounds reasonable to me (but I haven't checked it).  Might
> you want to minimize the diff to only contain the move of the sleep
> call?
>=20
> Kind regards,
> Nicolas
>=20
>=20
> >  samples/bpf/sockex2_user.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> > index 2c18471336f0..84bf1ab77649 100644
> > --- a/samples/bpf/sockex2_user.c
> > +++ b/samples/bpf/sockex2_user.c
> > @@ -18,8 +18,8 @@ int main(int ac, char **argv)
> >  	struct bpf_program *prog;
> >  	struct bpf_object *obj;
> >  	int map_fd, prog_fd;
> > -	char filename[256];
> > -	int i, sock, err;
> > +	char filename[256], command[64];
> > +	int i, sock, err, num =3D 5;
> >  	FILE *f;
> > =20
> >  	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
> > @@ -42,21 +42,22 @@ int main(int ac, char **argv)
> >  	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF,
> > &prog_fd, sizeof(prog_fd)) =3D=3D 0);
> > =20
> > -	f =3D popen("ping -4 -c5 localhost", "r");
> > +	snprintf(command, sizeof(command), "ping -4 -c%d
> > localhost", num);
> > +	f =3D popen(command, "r");
> >  	(void) f;
> > =20
> > -	for (i =3D 0; i < 5; i++) {
> > +	for (i =3D 0; i < num; i++) {
> >  		int key =3D 0, next_key;
> >  		struct pair value;
> > =20
> > +		sleep(1);
> >  		while (bpf_map_get_next_key(map_fd, &key,
> > &next_key) =3D=3D 0) { bpf_map_lookup_elem(map_fd, &next_key, &value);
> > -			printf("ip %s bytes %lld packets %lld\n",
> > +			printf("num =3D %d: ip %s bytes %lld packets
> > %lld\n", i, inet_ntoa((struct in_addr){htonl(next_key)}),
> >  			       value.bytes, value.packets);
> >  			key =3D next_key;
> >  		}
> > -		sleep(1);
> >  	}
> >  	return 0;
> >  }
> > --=20
> > 2.34.1 =20
>=20

hi=EF=BC=8C

the diff to only contain the move of the sleep call likes this:


diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index 2c18471336f0..82bb38b9cab0 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -49,6 +49,7 @@ int main(int ac, char **argv)
                int key =3D 0, next_key;
                struct pair value;
=20
+               sleep(1);
                while (bpf_map_get_next_key(map_fd, &key, &next_key) =3D=3D
0) { bpf_map_lookup_elem(map_fd, &next_key, &value);
                        printf("ip %s bytes %lld packets %lld\n",
@@ -56,7 +57,6 @@ int main(int ac, char **argv)
                               value.bytes, value.packets);
                        key =3D next_key;
                }
-               sleep(1);
        }
        return 0;
 }

